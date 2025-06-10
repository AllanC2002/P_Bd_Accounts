# Usa la imagen oficial de Microsoft SQL Server 2022
FROM mcr.microsoft.com/mssql/server:2022-latest

# Cambia temporalmente a root para instalar dependencias
USER root

# Instala gettext (para envsubst) como root
RUN apt-get update && \
    apt-get install -y gettext && \
    rm -rf /var/lib/apt/lists/*

# Vuelve al usuario mssql
USER mssql

# Variables de configuración (sin credenciales)
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

# Copia los archivos con permisos adecuados
COPY --chmod=755 entrypoint.sh /usr/local/bin/
COPY --chmod=644 init.template.sql /usr/local/bin/

# Directorio de trabajo
WORKDIR /usr/local/bin

# Puerto expuesto
EXPOSE 1434

# Punto de entrada
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]