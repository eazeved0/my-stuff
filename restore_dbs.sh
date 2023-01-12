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
echo "#!/bin/bash" |tee -a dump_all.sh 2>&1 1>/dev/null

echo "Downloading Dumps..."
mkdir -p db_dumps/auth && mkdir db_dumps/backoffice

authdb=$(aws rds --region sa-east-1 describe-db-clusters | jq '.DBClusters[] | .DBClusterIdentifier' |tr -d \" |grep -E 'kong|keycloak')
for i in $authdb ; do
  aws s3 cp s3://rds-backups-automation/pg_dump/backup_$i-$date.dump db_dumps/auth/
	username=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .MasterUsername' |tr -d \")
	database=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .DatabaseName' |tr -d \")
	echo "Restoring DB $database into Aurora Auth Cluster"
	PGPASSFILE=~/.pgpass psql -h $authrds -p 5432 -U $username $database < db_dumps/auth/backup_$i-$date.dump"
  echo "Done restoring DBs to Aurora Auth Cluster"
done

backofficedb=$(aws rds --region sa-east-1 describe-db-clusters | jq '.DBClusters[] | .DBClusterIdentifier' |tr -d \" |grep -Ev 'kong|keycloak')
for i in $backofficedb ; do
  aws s3 cp s3://rds-backups-automation/pg_dump/backup_$i-$date.dump db_dumps/backoffice/
	username=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .MasterUsername' |tr -d \")
	database=$(aws rds --region sa-east-1  describe-db-clusters --db-cluster-identifier $i |jq '.DBClusters[] .DatabaseName' |tr -d \")
	echo "Restoring DB $database into Aurora BackOffice Cluster"
	PGPASSFILE=~/.pgpass psql -h $backofficerds -p 5432 -U $username $database < db_dumps/backoffice/backup_$i-$date.dump"
  echo "Done restoring DBs to Aurora BackOffice Cluster"
done

echo "#### All done! ####"
