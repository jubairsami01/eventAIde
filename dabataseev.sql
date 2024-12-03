Usage: mysqldump [OPTIONS] database [tables]
OR     mysqldump [OPTIONS] --databases [OPTIONS] DB1 [DB2 DB3...]
OR     mysqldump [OPTIONS] --all-databases [OPTIONS]
For more options, use mysqldump --help
mysqldump -u [username] -p [database_name] > [filename].sql
CREATE DATABASE [new_database_name];

mysql -u [username] -p [new_database_name] < [filename].sql