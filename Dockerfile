# Usa la imagen oficial de Microsoft SQL Server 2022
FROM mcr.microsoft.com/mssql/server:2022-latest

# Instala dependencias necesarias (envsubst está en gettext)
RUN apt-get update && \
    apt-get install -y gettext && \
    rm -rf /var/lib/apt/lists/*

# Variables de configuración
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

# Copia solo los archivos que necesitas
COPY --chmod=755 entrypoint.sh /usr/local/bin/
COPY --chmod=644 init.template.sql /usr/local/bin/

# Directorio de trabajo
WORKDIR /usr/local/bin

# Puerto expuesto
EXPOSE 1434

# Punto de entrada
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]