#Auth database
PGPASSWORD=YOUR_PASSRORD pg_dump  -U <user_name> -h payment-v2.cliunremnqus.ap-south-1.rds.amazonaws.com auth  -f ippb_pg_auth.sql

#Payment_v2
PGPASSWORD=YOUR_PASSRORD pg_dump  -U <user_name> -h payment-v2.cliunremnqus.ap-south-1.rds.amazonaws.com payment_v2  -f ippb_payment_v2.sql

#Master_tool_db
PGPASSWORD=YOUR_PASSRORD pg_dump  -U <user_name> -h <host_name> master_tool_db  -f ippb_master_tool_db.sql

