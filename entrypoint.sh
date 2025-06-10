#!/bin/bash

# Verify the variables
if [[ -z "$MSSQL_SA_PASSWORD" || -z "$APP_USER_NAME" || -z "$APP_USER_PASSWORD" ]]; then
  echo "  - Chrashed: the system needs this variables:"
  echo "  - MSSQL_SA_PASSWORD"
  echo "  - APP_USER_NAME"
  echo "  - APP_USER_PASSWORD"
  exit 1
fi

# Replace the variables in the template
envsubst < /init.template.sql > /init.sql

# Start sqlserver
/opt/mssql/bin/sqlservr &

# Wait sqlserver to be ready
echo "⏳ Esperando a que SQL Server se inicialice..."
sleep 30

# Script sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -i /init.sql

# Container active
wait
