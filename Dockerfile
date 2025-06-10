# Usa la imagen oficial de Microsoft SQL Server 2022
FROM mcr.microsoft.com/mssql/server:2022-latest

# Instala dependencias necesarias (envsubst está en gettext)
RUN apt-get update && \
    apt-get install -y gettext && \
    rm -rf /var/lib/apt/lists/*

# Solo variables de configuración (no credenciales)
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

# Copia los archivos con permisos adecuados
COPY --chmod=755 entrypoint.sh /usr/local/bin/
COPY --chmod=644 init.template.sql /usr/local/bin/
COPY --chmod=755 wait /usr/local/bin/

# Directorio de trabajo
WORKDIR /usr/local/bin

# Puerto expuesto
EXPOSE 1433

# Punto de entrada
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]