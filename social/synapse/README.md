# Synapse Deployment

Synapse deployment using the element-hq [ess-helm](https://github.com/element-hq/ess-helm/tree/main) charts.

## Staging Test Steps

1. Deployed a CNPG cluster first so I could understand what databases and accounts needed to be created.
2. Followed Database Setup Guides:
   1. https://element-hq.github.io/synapse/latest/postgres.html#set-up-database
      1. CREATE USER "synapse-st";
      2. ALTER USER "synapse-st" WITH PASSWORD 'IRPASSWORD';
      3. CREATE DATABASE synapse WITH OWNER="synapse-st" TEMPLATE=template0 LOCALE="C" ENCODING=UTF8;
   2. https://element-hq.github.io/matrix-authentication-service/setup/database.html
      1. CREATE USER "synapse-st-mas";
      2. ALTER USER "synapse-st-mas" WITH PASSWORD 'IRPASSWORD';
      3. CREATE DATABASE "synapse-mas" WITH OWNER="synapse-st-mas";
3. Deployed Helm Chart allowing it to create it's own secrets
4. Created user according to ESS docs

## Main Server Replacement

1. Deployed a CNPG cluster.
2. Followed Database Setup Guides:
   1. https://element-hq.github.io/synapse/latest/postgres.html#set-up-database
      1. CREATE USER "synapse-";
      2. ALTER USER "synapse-" WITH PASSWORD 'IRPASSWORD';
      3. CREATE DATABASE synapse WITH OWNER="synapse-" TEMPLATE=template0 LOCALE="C" ENCODING=UTF8;
   2. https://element-hq.github.io/matrix-authentication-service/setup/database.html
      1. CREATE USER "synapse--mas";
      2. ALTER USER "synapse--mas" WITH PASSWORD 'IRPASSWORD';
      3. CREATE DATABASE "synapse-mas" WITH OWNER="synapse--mas";
3. Deployed Helm Chart allowing it to create it's own secrets
4. Created user according to ESS docs