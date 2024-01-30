get_pufferfish_server() {
  if [[ -z "$RAM" ]]; then
    MC_VERSION="1.20"
  fi
  majorVersion=$MC_VERSION
  PUFFERFISH_BUILD_JSON=$(curl -X GET -s "https://ci.pufferfish.host/job/Pufferfish-${majorVersion}/lastSuccessfulBuild/api/json")
  PUFFERFISH_BUILD_URL=$(jq -n "$PUFFERFISH_BUILD_JSON" | jq -jc '.url // empty' )
  PUFFERFISH_BUILD_FILENAME=$(jq -n "$PUFFERFISH_BUILD_JSON" | jq -jc '.artifacts[].fileName // empty' )
  PUFFERFISH_BUILD_DOWNLOAD_URL="${PUFFERFISH_BUILD_URL}artifact/build/libs/${PUFFERFISH_BUILD_FILENAME}"

  shopt -s nullglob

  if [ -f "pufferfish.jar" ]; then
    rm "pufferfish.jar"
  fi

  wget --quiet -O pufferfish.jar -T 60 $PUFFERFISH_BUILD_DOWNLOAD_URL
}

if [[ ! -e "/localcache/conf-saved.txt" ]]; then
  cp -R /mcfiles /usr/src/
  touch /localcache/conf-saved.txt
fi

cd /usr/src/mcfiles/ || exit

if [[ ! -e "pufferfish.jar" ]]; then
  get_pufferfish_server
else
  if [[ "$FORCE_REINSTALL" -eq 1 ]]; then
    get_pufferfish_server
  fi
fi

if [[ -z "$RAM" ]]; then
  RAM="1G"
fi

java -Xms$RAM -Xmx$RAM -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar pufferfish.jar nogui

sleep 10