#!/bin/bash

apt-get update -y && apt-get upgrade -y

apt-get install -y python3.11 python3-pip git

useradd -m -s /bin/bash bahjat-mini-project
mkdir -p /home/bahjat-mini-project/app
chown -R bahjat-mini-project:bahjat-mini-project /home/bahjat-mini-project/app

cd /home/bahjat-mini-project/app

git clone https://github.com/bahjatnsasra/NewTech_DevOps_Nov25.git .
chown -R bahjat-mini-project:bahjat-mini-project /home/bahjat-mini-project/app

python3 -m venv minienv

source minienv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

pip install gunicorn

tee /etc/systemd/system/flaskapp.service > /dev/null <<EOF
[Unit]
Description=Gunicorn service for Flask app
After=network.target

[Service]
User=ubuntu
Group=bahjat-mini-project
WorkingDirectory=/home/ubuntu/app/mini-project1/app
Environment="PATH=/home/bahjat-mini-project/app/minienv/bin"
ExecStart=/home/ubuntu/app/minienv/bin/gunicorn --workers 3 --bind 0.0.0.0:5000 main:app

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable flaskapp
systemctl start flaskapp


#!/bin/bash

apt-get update -y && apt-get upgrade -y

apt-get install -y python3.11 python3-pip git

useradd -m -s /bin/bash bahjat-mini-project
mkdir -p /home/bahjat-mini-project/app
chown -R bahjat-mini-project:bahjat-mini-project /home/bahjat-mini-project/app

cd /home/bahjat-mini-project/app

git clone https://github.com/bahjatnsasra/NewTech_DevOps_Nov25.git .
chown -R bahjat-mini-project:bahjat-mini-project /home/bahjat-mini-project/app

python3 -m venv /home/bahjat-mini-project/app/minienv

/home/bahjat-mini-project/app/minienv/bin/pip install --upgrade pip
/home/bahjat-mini-project/app/minienv/bin/pip install -r /home/bahjat-mini-project/app/mini-project1/app/requirements.txt

/home/bahjat-mini-project/app/minienv/bin/pip install gunicorn

tee /etc/systemd/system/flaskapp.service > /dev/null <<EOF
[Unit]
Description=Gunicorn service for Flask app
After=network.target

[Service]
User=bahjat-mini-project
Group=bahjat-mini-project
WorkingDirectory=/home/bahjat-mini-project/app/mini-project1/app
Environment="PATH=/home/bahjat-mini-project/app/minienv/bin"
ExecStart=/home/bahjat-mini-project/app/minienv/bin/gunicorn --workers 3 --bind 0.0.0.0:5000 main:app

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable flaskapp
systemctl start flaskapp
