PGPASSFILE=~/.pgpass pg_dump -h destaxa-bpm.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_bpm | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-bpm.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h destaxa-comission.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_comission | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-comission.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h destaxa-company.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_company | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-company.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h destaxa-document-validation.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_document_validation | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-document-validation.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h destaxa-financial.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_financial | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-financial.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h destaxa-person.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_person | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-person.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h destaxa-plan.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_plan | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-plan.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h destaxa-product.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres destaxa_product | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_destaxa-product.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h keycloak-dev.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres keycloak | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_keycloak-dev.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h kong.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres kong | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_kong.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h platform-commons.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres platform_commons | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_platform-commons.sql-2023-01-11.sql
PGPASSFILE=~/.pgpass pg_dump -h platform-sso.cluster-ro-cvgax45xgjcg.sa-east-1.rds.amazonaws.com -p 5432 -U postgres postgres | aws s3 cp - s3://rds-backups-automation/pg_dump/backup_platform-sso.sql-2023-01-11.sql
