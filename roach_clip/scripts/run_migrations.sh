#! /bin/bash

cat << EOF > config.json
{
	"database": {
		"name": "temporal",
		"url": "localhost",
		"port": "5432",
		"username": "temporaladmin",
		"password": "temporaladmin"
	},
	"log_dir": "/var/log/temporal/"
}
EOF