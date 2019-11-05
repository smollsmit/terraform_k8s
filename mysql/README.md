# Mysql instance operations

## Get instances by lable 
```
cloud sql instances list --filter labels.env=dev
```
## Import sql dump to instance
```
 gcloud sql import sql <mysql-instance> <gs://bucket/template.sql.gz> --database=<db> --quiet
```