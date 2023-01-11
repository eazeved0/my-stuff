curl -s -L https://raw.githubusercontent.com/eazeved0/my-stuff/main/migrate_databases.sh | bash -x


echo "Dumping database destaxa_bpm"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h destaxa-bpm.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_bpm | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-bpm-2023-01-11.dump
echo "Dumping database destaxa_comission"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h destaxa-comission.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_comission | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-comission-2023-01-11.dump
echo "Dumping database destaxa_company"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h destaxa-company.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_company | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-company-2023-01-11.dump
echo "Dumping database destaxa_document_validation"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h destaxa-documentalidation.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_document_validation | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-documentalidation-2023-01-11.dump
echo "Dumping database destaxa_financial"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h destaxa-financial.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_financial | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-financial-2023-01-11.dump
echo "Dumping database destaxa_person"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h destaxa-person.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_person | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-person-2023-01-11.dump
echo "Dumping database destaxa_plan"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h destaxa-plan.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_plan | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-plan-2023-01-11.dump
echo "Dumping database destaxa_product"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h destaxa-product.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_product | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-product-2023-01-11.dump
echo "Dumping database keycloak"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h keycloak-dev.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres keycloak | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_keycloak-dev-2023-01-11.dump
echo "Dumping database kong"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h kong.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres kong | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_kong-2023-01-11.dump
echo "Dumping database platform_commons"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h platform-commons.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres platform_commons | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_platform-commons-2023-01-11.dump
echo "Dumping database platform-sso"
PGPASSFILE=~/.pgpass pg_dump -Fc  -h platform-sso.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres postgres | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_platform-sso-2023-01-11.dump
