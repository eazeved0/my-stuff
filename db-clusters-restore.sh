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
authrds="destaxa-dev-auth-instance-1.cvgax45xgjcg.sa-east-1.rds.amazonaws.com"
backofficerds="destaxa-dev-backoffice-instance-1.cvgax45xgjcg.sa-east-1.rds.amazonaws.com"

echo "Downloading Dumps..."
[[ -d db_dumps/auth ]] && rm -r db_dumps/auth
mkdir -p db_dumps/auth && mkdir db_dumps/backoffice

backoffice=$(aws rds --region sa-east-1 describe-db-clusters | jq '.DBClusters[] | .DBClusterIdentifier' |tr -d \" |grep -Ev 'kong|keycloak|destaxa-dev-commons|destaxa-dev-auth|destaxa-dev-backoffice|destaxa-bpm')
for i in $backoffice ; do
  aws s3 cp s3://rds-backups-automation/pg_dump/backup_$i-$date.sql db_dumps/backoffice/
	username=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .MasterUsername' |tr -d \")
	database=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .DatabaseName' |tr -d \")
	echo "Restoring DB $database into Aurora BackOffice Cluster"
	PGPASSFILE=~/.pgpass pg_restore -c --create -Ft -h $backofficerds -U $username -C -d postgres  < db_dumps/backoffice/backup_$i-$date.sql
  echo "Done restoring DBs to Aurora BackOffice Cluster"
done

for auth in $(aws rds --region sa-east-1 describe-db-clusters | jq '.DBClusters[] | .DBClusterIdentifier' |tr -d \" |grep -E 'kong|keycloak') ; do
  aws s3 cp s3://rds-backups-automation/pg_dump/backup_$auth-$date.sql db_dumps/auth/
	username=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .MasterUsername' |tr -d \")
	database=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .DatabaseName' |tr -d \")
	echo "Restoring DB $auth into Aurora Auth Cluster"
	PGPASSFILE=~/.pgpass pg_restore -c --create -Ft -h $authrds -U $username -C -d postgres < db_dumps/auth/backup_$auth-$date.sql
  echo "Done restoring DBs to Aurora Auth Cluster"
done  

echo "#### All done! ####"
