# Example openconnect conf in docker

### connect to server and copy files

ssh user@ip -p port

scp -r -P port path-to-dir-wit-docker-compose user@ip:/home/user/openconnect

### create user
ocpasswd -c /etc/ocserv/ocpasswd testuser

### block 
ocpasswd -c /etc/ocserv/ocpasswd -l username

### unblock
ocpasswd -c /etc/ocserv/ocpasswd -u username

### unit for systemd
cp ./openconnect.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl status openconnect.service

### ports
ufw allow {port}/tcp
sudo ufw status verbose
sudo ufw enable && sudo systemctl restart ufw