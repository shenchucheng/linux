#!/usr/bin/sh
tar -xvf node_exporter*.tar.gz
mv -f node_exporter* /opt/node_exporter
ln -sf /opt/node_exporter/node_exporter /usr/local/bin 
ln -sf /opt/node_exporter/node_exporter.service /usr/lib/systemd/system 
tee /opt/node_exporter/node_exporter.service <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF 
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter
