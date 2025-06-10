FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=TuPasswordSegura123

COPY entrypoint.sh /entrypoint.sh
COPY init.template.sql /init.template.sql

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]