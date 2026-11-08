-- DEVELOPMENT-ONLY SEED FILE — NEVER EXECUTE IN PRODUCTION ENVIRONMENTS.
-- Creates local test accounts (PARENT, TEACHER, ADMIN) hashed with BCrypt cost 12.
-- Pass the password at runtime via psql variable (never hardcode passwords in git):
--   psql "$DATABASE_URL" -v dev_password='<dev-password>' -f seeds/02_dev_role_users.sql

\if :{?dev_password}
\else
  \echo 'ERROR: Missing required psql variable dev_password (-v dev_password=...)'
  \quit 1
\endif

INSERT INTO identity_schema.schools (id, name, code, contact_email)
VALUES ('11111111-1111-1111-1111-111111111111', 'Colegio Corhuila EduTrack', 'CORH-01', 'contacto@corhuila.edu.co')
ON CONFLICT (code) DO NOTHING;

INSERT INTO identity_schema.users (id, email, password_hash, name, role, school_id, status)
VALUES
  (
    '22222222-2222-4000-8000-000000000001',
    'maria.lopez@edutrack.edu.co',
    crypt(:'dev_password', gen_salt('bf', 12)),
    'María López',
    'PARENT',
    (SELECT id FROM identity_schema.schools WHERE code = 'CORH-01'),
    'ACTIVE'
  ),
  (
    '22222222-2222-4000-8000-000000000002',
    'carlos.ramirez@edutrack.edu.co',
    crypt(:'dev_password', gen_salt('bf', 12)),
    'Prof. Carlos Ramírez',
    'TEACHER',
    (SELECT id FROM identity_schema.schools WHERE code = 'CORH-01'),
    'ACTIVE'
  ),
  (
    '22222222-2222-4000-8000-000000000003',
    'rectoria@edutrack.edu.co',
    crypt(:'dev_password', gen_salt('bf', 12)),
    'Mag. Juan Pérez',
    'ADMIN',
    (SELECT id FROM identity_schema.schools WHERE code = 'CORH-01'),
    'ACTIVE'
  )
ON CONFLICT (email) DO NOTHING;
