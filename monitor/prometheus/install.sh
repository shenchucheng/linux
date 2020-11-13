#!/usr/bin/sh
groupadd --system prometheus
useradd -s /sbin/nologin --system -g prometheus prometheus 
mkdir /var/lib/prometheus
mkdir /etc/prometheus 
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done
mkdir /opt/prometheus
tar xvf prometheus*.tar.gz -C /opt/prometheus
mv /opt/prometheus-* /opt/prometheus 
ln -sf /opt/prometheus/prometheus /usr/local/bin 
ln -sf /opt/prometheus/promtool /usr/local/bin
ln -sf /opt/prometheus/prometheus.yml /etc/prometheus
ln -sf /opt/prometheus/consoles /etc/prometheus 
ln -sf /opt/prometheus/prometheus.service /usr/lib/systemd/system 
tee /opt/prometheus/prometheus.service<<EOF

[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
EOF
for i in rules rules.d files_sd; do sudo chown -R prometheus:prometheus /etc/prometheus/${i}; done
for i in rules rules.d files_sd; do sudo chmod -R 775 /etc/prometheus/${i}; done
chown -R prometheus:prometheus /var/lib/prometheus/
systemctl daemon-reload
systemctl start prometheus
systemctl enable prometheus
