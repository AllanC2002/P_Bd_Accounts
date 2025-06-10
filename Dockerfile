FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA=Y

COPY --chmod=755 entrypoint.sh /entrypoint.sh
COPY --chmod=644 init.template.sql /init.template.sql

EXPOSE 1433

CMD ["/entrypoint.sh"]