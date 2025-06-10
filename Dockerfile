FROM mcr.microsoft.com/mssql/server:2022-latest

USER root

# Instala dependencias y crea directorio con permisos adecuados
RUN apt-get update && \
    apt-get install -y gettext && \
    mkdir -p /sqlscripts && \
    chown mssql /sqlscripts && \
    rm -rf /var/lib/apt/lists/*

USER mssql

ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

# Copia los archivos al directorio con permisos
COPY --chown=mssql --chmod=644 init.template.sql /sqlscripts/
COPY --chown=mssql --chmod=755 entrypoint.sh /sqlscripts/

WORKDIR /sqlscripts

EXPOSE 1434

ENTRYPOINT ["/sqlscripts/entrypoint.sh"]