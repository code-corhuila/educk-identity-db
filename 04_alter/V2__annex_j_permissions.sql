-- Domain-owned grants; migration history is deliberately excluded.
GRANT USAGE ON SCHEMA identity_schema TO identity_reader, identity_writer;
GRANT SELECT ON identity_schema.schools, identity_schema.users, identity_schema.students, identity_schema.parent_child_link, identity_schema.refresh_tokens TO identity_reader;
GRANT SELECT, INSERT, UPDATE, DELETE ON identity_schema.schools, identity_schema.users, identity_schema.students, identity_schema.parent_child_link, identity_schema.refresh_tokens TO identity_writer;
