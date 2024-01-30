if [[ -z "$SSH_PASSWORD" ]]; then
  export SSH_PASSWORD=admin
fi

mkdir /var/run/sshd
echo "root:$SSH_PASSWORD" | chpasswd
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

exec /usr/sbin/sshd -D