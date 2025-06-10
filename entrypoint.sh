#!/bin/bash

# Verificar variables
if [[ -z "$MSSQL_SA_PASSWORD" || -z "$APP_USER_NAME" || -z "$APP_USER_PASSWORD" ]]; then
  echo "Error: Missing required environment variables" >&2
  exit 1
fi

# Ruta al directorio con permisos
SCRIPT_DIR="/sqlscripts"

# Generar script SQL final
envsubst < "$SCRIPT_DIR/init.template.sql" > "$SCRIPT_DIR/init.sql"

# Iniciar SQL Server en segundo plano
/opt/mssql/bin/sqlservr &

# Esperar inicialización
echo "⏳ Waiting for SQL Server to start..."
for i in {1..30}; do
  if /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -Q "SELECT 1" &> /dev/null; then
    break
  fi
  echo "⏳ Not ready yet (attempt $i/30), waiting 5s..."
  sleep 5
done

# Ejecutar script
echo "✅ SQL Server ready. Running initialization script..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -i "$SCRIPT_DIR/init.sql"

# Mantener contenedor activo
wait