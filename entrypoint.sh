#!/bin/bash

# Verificar variables necesarias
if [[ -z "$MSSQL_SA_PASSWORD" || -z "$APP_USER_NAME" || -z "$APP_USER_PASSWORD" ]]; then
  echo "  - Chrashed: the system needs this variables:"
  echo "  - MSSQL_SA_PASSWORD"
  echo "  - APP_USER_NAME"
  echo "  - APP_USER_PASSWORD"
  exit 1
fi

# Reemplazar variables en la plantilla SQL
envsubst < /init.template.sql > /init.sql

# Iniciar SQL Server en segundo plano
/opt/mssql/bin/sqlservr &

# Esperar que SQL Server esté listo con un bucle
echo "⏳ Esperando a que SQL Server se inicialice..."

until /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -Q "SELECT 1" > /dev/null 2>&1; do
  echo "⏳ SQL Server no está listo aún, esperando 5 segundos..."
  sleep 5
done

echo "✅ SQL Server está listo."

# Ejecutar el script SQL para crear DB, usuario, tablas, etc.
echo "Ejecutando script de inicialización..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -i /init.sql

# Mantener el contenedor activo (esperar a que sqlservr termine)
/wait
