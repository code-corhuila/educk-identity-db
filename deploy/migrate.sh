#!/bin/sh
set -eu
mkdir -p /tmp/domain-migrations
cp /domain/01_ddl/V1.2__create_identity_tables.sql /tmp/domain-migrations/
cp /domain/04_alter/V1.3__add_identity_foreign_keys.sql /tmp/domain-migrations/
cp /domain/04_alter/V2__annex_j_permissions.sql /tmp/domain-migrations/
exec flyway -locations=filesystem:/tmp/domain-migrations -schemas=identity_schema -defaultSchema=identity_schema -cleanDisabled=true migrate
