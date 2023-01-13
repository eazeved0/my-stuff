#!/bin/bash

cd $HOME
echo "Installing dependencies..."
curl -s https://raw.githubusercontent.com/eazeved0/my-stuff/main/pgdg.repo -O
sudo mv pgdg.repo /etc/yum.repos.d/
sudo amazon-linux-extras install epel -y 2>&1 1>/dev/null
sudo yum install postgresql14 jq -y -q
aws s3 --region sa-east-1 cp s3://rds-backups-automation/pg_dump/sct/.pgpass $HOME/.pgpass
export PGPASSFILE=~/.pgpass
sudo chmod 0600 /home/ssm-user/.pgpass
date=$(date +%d-%m-%y)
echo "#!/bin/bash" |tee dump_all.sh 2>&1 1>/dev/null

echo "Preparing Manifests"

clusters=$(aws rds --region sa-east-1 describe-db-clusters | jq '.DBClusters[] | .DBClusterIdentifier' |tr -d \" |grep -Ev 'destaxa-dev-commons|destaxa-dev-auth|destaxa-dev-backoffice')
for i in $clusters ; do
	endpoint=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .ReaderEndpoint' |tr -d \")
	username=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .MasterUsername' |tr -d \")
	database=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .DatabaseName' |tr -d \")
	echo "echo \"Creating $database Backup\" " |tee -a dump_all.sh 2>&1 1>/dev/null
	echo "PGPASSFILE=~/.pgpass pg_dump -Ft --create -s -h $endpoint -U $username -d $database | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_$i-$date.sql" |tee -a dump_all.sh 2>&1 1>/dev/null
done
sed -i.bu 's/null/postgres/' dump_all.sh
aws s3 --region sa-east-1  cp dump_all.sh  s3://rds-backups-automation/pg_dump/dump_all.sh 2>&1 1>/dev/null
echo " ### Dumping dbs to S3... ####"
bash ./dump_all.sh
echo "#### All done! ####"
