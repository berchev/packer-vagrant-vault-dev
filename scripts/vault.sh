#!/usr/bin/env bash

# Install latest version of vault
pushd /usr/local/bin
VAULT_URL=$(curl https://releases.hashicorp.com/index.json | jq '{vault}' | egrep "linux.*amd64" | sort -r | head -1 | awk -F[\"] '{print $4}')
curl -o vault.zip ${VAULT_URL}
unzip vault.zip
rm -f vault.zip
popd

# Installing autocomplete
echo 'complete -C /usr/local/bin/vault vault' | tee -a /home/vagrant/.bashrc

# Give Vault the ability to use the mlock syscall without running the process as root. The mlock syscall prevents memory from being swapped to disk.
setcap cap_ipc_lock=+ep /usr/local/bin/vault

# Createting System D service for vault
cat > /etc/systemd/system/vault.service << EOF
[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/
Requires=network-online.target
After=network-online.target

[Service]
ProtectSystem=full
PrivateTmp=yes
PrivateDevices=yes
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server -dev -dev-listen-address 0.0.0.0:8200 -dev-root-token-id changeme
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGINT
Restart=on-failure
RestartSec=5
TimeoutStopSec=30
StartLimitIntervalSec=60
StartLimitBurst=3
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target
EOF

# Start Vault
systemctl enable vault
systemctl start vault
