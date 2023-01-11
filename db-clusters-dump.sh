#!/bin/bash

cd $HOME
echo "Installing dependencies..."
curl -s https://raw.githubusercontent.com/eazeved0/my-stuff/main/pgdg.repo -O
sudo mv pgdg.repo /etc/yum.repos.d/
sudo amazon-linux-extras install epel -y 2>&1 1>/dev/null
sudo yum install postgresql14 jq -y -q
curl -s https://raw.githubusercontent.com/eazeved0/my-stuff/main/.pgpass -O
sudo chmod 0600 /home/ssm-user/.pgpass
export PGPASSFILE=~/.pgpass

date=$(date +%d-%m-%y)
echo "#!/bin/bash" |tee -a dump_all.sh 2>&1 1>/dev/null
echo "Creating Datasets"

clusters=$(aws rds --region sa-east-1 describe-db-clusters | jq '.DBClusters[] | .DBClusterIdentifier' |tr -d \" |grep -v destaxa-dev-commons)
for i in $clusters ; do
	endpoint=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .ReaderEndpoint' |tr -d \")
	username=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .MasterUsername' |tr -d \")
	database=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .DatabaseName' |tr -d \")
	echo "echo \"Creating $database Backup\" " |tee -a dump_all.sh 2>&1 1>/dev/null
	echo "PGPASSFILE=~/.pgpass pg_dump -Fc -h $endpoint -p 5432 -U $username $database | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_$i-$date.dump" |tee -a dump_all.sh 2>&1 1>/dev/null
	chmod +x dump_all.sh
done
sed -i.bu 's/null/postgres/' dump_all.sh
aws s3 --region sa-east-1  cp dump_all.sh  s3://rds-backups-automation/pg_dump/dump_all.sh 2>&1 1>/dev/null
echo "Dumping dbs to S3..."
chmod +x dump_all.sh && ./dump_all.sh
echo "All done!"
