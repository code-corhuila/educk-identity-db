-- DEV ONLY - nunca ejecutar en produccion. Cuentas demo (ADMIN, TEACHER, PARENT), estudiante 201 y vinculo.
-- Uso (UTF-8 obligatorio para acentos):
--   psql "$DATABASE_URL" -v dev_password='<clave-dev>' -f seeds/dev/03_demo_accounts_and_student.sql
SET client_encoding = 'UTF8';

\if :{?dev_password}
\else
  \echo 'ERROR: falta la variable psql dev_password (-v dev_password=...)'
  \quit 1
\endif

CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO identity_schema.schools (id, name, code, contact_email)
VALUES ('11111111-1111-1111-1111-111111111111', 'Colegio Corhuila EduTrack', 'CORH-01', 'contacto@corhuila.edu.co')
ON CONFLICT (code) DO NOTHING;

INSERT INTO identity_schema.users (id, email, password_hash, name, role, school_id, status)
VALUES
  ('00000000-0000-4000-8000-000000000001', 'admin@edutrack.edu.co', crypt(:'dev_password', gen_salt('bf', 12)),
   'Administrador Institucional', 'ADMIN', '11111111-1111-1111-1111-111111111111', 'ACTIVE'),
  ('00000000-0000-4000-8000-000000000101', 'profesor.ariel@edutrack.edu.co', crypt(:'dev_password', gen_salt('bf', 12)),
   'Jesús Ariel González', 'TEACHER', '11111111-1111-1111-1111-111111111111', 'ACTIVE'),
  ('00000000-0000-4000-8000-000000000301', 'acudiente@edutrack.edu.co', crypt(:'dev_password', gen_salt('bf', 12)),
   'María López', 'PARENT', '11111111-1111-1111-1111-111111111111', 'ACTIVE')
ON CONFLICT (email) DO UPDATE SET
  password_hash = EXCLUDED.password_hash, name = EXCLUDED.name, role = EXCLUDED.role,
  school_id = EXCLUDED.school_id, status = 'ACTIVE', updated_at = NOW();

INSERT INTO identity_schema.students (id, name, school_id, grade_level, status)
VALUES ('00000000-0000-4000-8000-000000000201', 'Juan Sebastián López',
        '11111111-1111-1111-1111-111111111111', '10-A', 'ACTIVE')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, grade_level = EXCLUDED.grade_level, updated_at = NOW();

INSERT INTO identity_schema.parent_child_link (parent_id, student_id, relationship)
SELECT id, '00000000-0000-4000-8000-000000000201', 'MOTHER'
FROM identity_schema.users WHERE email = 'acudiente@edutrack.edu.co'
ON CONFLICT (parent_id, student_id) DO UPDATE SET relationship = EXCLUDED.relationship;
