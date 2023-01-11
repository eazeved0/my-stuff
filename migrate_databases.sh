bash
cd /home/ssm-user
echo "Installing dependencies..."
curl -s https://raw.githubusercontent.com/eazeved0/my-stuff/main/pgdg.repo -O
sudo mv pgdg.repo /etc/yum.repos.d/
sudo amazon-linux-extras install epel -y 2>&1 /dev/null
sudo yum install postgresql14 -y -q
curl -s https://raw.githubusercontent.com/eazeved0/my-stuff/main/.pgpass -O
sudo chmod 0600 /home/ssm-user/.pgpass
export PGPASSFILE=~/.pgpass

sleep 2
echo "Starting backups..."
bash <(curl -s https://raw.githubusercontent.com/eazeved0/my-stuff/main/dump.sh)
