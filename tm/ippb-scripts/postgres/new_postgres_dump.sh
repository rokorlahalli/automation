mkdir ippb-postgres-dump

cd ippb-postgres-dump

pg_dump  -U <username> -h <hostname> auth -s -f auth_schema.sql

pg_dump  -U <username> -h <hostname> notifications -s -f notifications_schema.sql

#Master_tool_db
PGPASSWORD=YOUR_PASSRORD pg_dump  -U <user_name> -h <host_name> master_tool_db  -f ippb_master_tool_db.sql

/usr/local/bin/aws s3 cp ippb-postgres-dump s3://ippb-migration-dump/postgres/ --recursive
