# Annex J deployment

The infrastructure owns PostgreSQL, its volume, pgcrypto and roles. This repository
only migrates identity_schema, authenticated as identity_migrator. The API uses
identity_app with DML grants, without superuser or schema creation privileges.
Flyway history is identity_schema.flyway_schema_history; the app cannot modify it.

Run the identity-db-migrate service from the infrastructure Compose. Re-running
applies only pending versions. Applied SQL files remain byte-for-byte unchanged.
Historic CREATE EXTENSION IF NOT EXISTS statements are retained for checksum
compatibility; pgcrypto must already exist, owned and initialized by infrastructure.
The explicit manifest excludes the duplicate, obsolete V1.2 refresh-token script; the canonical V1.2 create_identity_tables already includes the complete table.

This executor targets a new shared instance. Do not point it at an existing
nonempty domain without checking its Flyway history and taking a backup. Import
from old per-domain instances requires a separately validated data migration;
never reset or delete the original volumes.

The legacy V1.1 schema bootstrap is retained but excluded from this new-instance manifest: infrastructure creates the schema and owner before restricted migrations. Never reuse this manifest against an old migration history without reconciliation.
