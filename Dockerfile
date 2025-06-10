FROM mcr.microsoft.com/mssql/server:2022-latest

USER root

RUN apt-get update && \
    apt-get install -y gettext && \
    rm -rf /var/lib/apt/lists/*

USER mssql

ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

# Copiamos los archivos a la misma ubicación que referencia el entrypoint.sh
COPY --chmod=755 entrypoint.sh /entrypoint.sh
COPY --chmod=644 init.template.sql /init.template.sql

EXPOSE 1433

ENTRYPOINT ["/entrypoint.sh"]