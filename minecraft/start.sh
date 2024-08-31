delete_server() {
  shopt -s nullglob

  if [ -f "server.jar" ]; then
    rm "server.jar"
  fi
}

get_paper_server() {
  if [[ -z "$MC_VERSION" ]]; then
    MC_VERSION="1.20"
  fi
  
  majorVersion=$MC_VERSION
  PAPER_BUILD_JSON=$(curl -X GET -s "https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds")
  PAPER_BUILD_FILENAME=$(jq -n "$PAPER_BUILD_JSON" | jq -jc '.builds[-1].downloads.application.name')
  PAPER_BUILD_NUMBER=$(jq -n "$PAPER_BUILD_JSON" | jq '.builds[-1].build')
  PAPER_BUILD_DOWNLOAD_URL="https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/${PAPER_BUILD_NUMBER}/downloads/${PAPER_BUILD_FILENAME}"

  delete_server

  wget --quiet -O server.jar -T 60 $PAPER_BUILD_DOWNLOAD_URL
}

get_pufferfish_server() {
  if [[ -z "$MC_VERSION" ]]; then
    MC_VERSION="1.20"
  fi
  
  majorVersion=$MC_VERSION
  PUFFERFISH_BUILD_JSON=$(curl -X GET -s "https://ci.pufferfish.host/job/Pufferfish-${majorVersion}/lastSuccessfulBuild/api/json")
  PUFFERFISH_BUILD_URL=$(jq -n "$PUFFERFISH_BUILD_JSON" | jq -jc '.url // empty' )
  PUFFERFISH_BUILD_FILENAME=$(jq -n "$PUFFERFISH_BUILD_JSON" | jq -jc '.artifacts[].fileName // empty' )
  PUFFERFISH_BUILD_DOWNLOAD_URL="${PUFFERFISH_BUILD_URL}artifact/build/libs/${PUFFERFISH_BUILD_FILENAME}"

  delete_server

  wget --quiet -O server.jar -T 60 $PUFFERFISH_BUILD_DOWNLOAD_URL
}

get_purpur_server() {
  if [[ -z "$MC_VERSION" ]]; then
    MC_VERSION="1.20"
  fi

  PURPUR_BUILD_DOWNLOAD_URL="https://api.purpurmc.org/v2/purpur/${MC_VERSION}/latest/download"

  delete_server

  wget --quiet -O server.jar -T 60 $PURPUR_BUILD_DOWNLOAD_URL
}

get_custom_server() {
  if [[ -z "$CUSTOM_BUILD_URL" ]]; then
    get_paper_server
  else
    delete_server
    wget --quiet -O server.jar -T 60 $CUSTOM_BUILD_URL
  fi
}

get_server() {
  if [[ -z "$MC_SERVER" ]]; then
    MC_SERVER="paper"
  fi

  if [[ "$MC_SERVER" = "pufferfish" ]]; then
    get_pufferfish_server
  fi
  if [[ "$MC_SERVER" = "purpur" ]]; then
    get_purpur_server
  fi
  if [[ "$MC_SERVER" = "paper" ]]; then
    get_paper_server
  fi
  if [[ "$MC_SERVER" = "custom" ]]; then
    get_custom_server
  fi
}

if [[ ! -e "/localcache/conf-saved.txt" ]]; then
  cp -R /mcfiles /usr/src/
  touch /localcache/conf-saved.txt
fi

cd /usr/src/mcfiles/ || exit

if [[ ! -e "server.jar" ]]; then
  get_server
else
  if [[ "$FORCE_REINSTALL" -eq 1 ]]; then
    get_server
  fi
fi

if [[ -z "$RAM" ]]; then
  RAM="1G"
fi

mkdir -p plugins

if [[ "$SUPPORT_BEDROCK" -eq 1 ]]; then
  if [[ ! -e "plugins/geyser.jar" ]]; then
    GEYSER_BUILD_DOWNLOAD_URL="https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"

    wget --quiet -O plugins/geyser.jar -T 60 $GEYSER_BUILD_DOWNLOAD_URL
  fi
  if [[ ! -e "plugins/floodgate.jar" ]]; then
    FLOODGATE_BUILD_DOWNLOAD_URL="https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"

    wget --quiet -O plugins/floodgate.jar -T 60 $FLOODGATE_BUILD_DOWNLOAD_URL
  fi
fi


java -Xms$RAM -Xmx$RAM -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui

sleep 10
