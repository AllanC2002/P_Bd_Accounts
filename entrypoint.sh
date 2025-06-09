#!/bin/bash
# Verify of the sets about the variables 
if [[ -z "$MSSQL_SA_PASSWORD" || -z "$APP_USER_NAME" || -z "$APP_USER_PASSWORD" ]]; then
  echo "Crashed: You need this variables:"
  echo "  - MSSQL_SA_PASSWORD"
  echo "  - APP_USER_NAME"
  echo "  - APP_USER_PASSWORD"
  exit 1
fi

envsubst < /init.template.sql > /init.sql
/opt/mssql/bin/sqlservr &
echo "Waiting SQL Server inicializing..."
sleep 30

# Script
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -i /init.sql

# Container runs
wait
