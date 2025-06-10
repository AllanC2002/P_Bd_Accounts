FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA=Y

COPY --chmod=755 entrypoint.sh /entrypoint.sh

COPY --chmod=644 init.template.sql /init.sql

EXPOSE 1434

CMD ["/entrypoint.sh"]