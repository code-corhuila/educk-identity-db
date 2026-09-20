-- Seed básico de prueba con UUIDs estándar
INSERT INTO schools (id, name, code, contact_email)
VALUES ('11111111-1111-1111-1111-111111111111', 'Colegio Corhuila EduTrack', 'CORH-01', 'contacto@corhuila.edu.co')
ON CONFLICT (code) DO NOTHING;

INSERT INTO users (id, email, password_hash, name, role, school_id)
VALUES ('22222222-2222-2222-2222-222222222222', 'admin@corhuila.edu.co', '$2a$12$e8F0l1Kz5jH0iF8t6uN.xOXr6Z5B0h5iU5oQ8Q2W8O5K1mN3R9', 'Admin Institucional', 'ADMIN', '11111111-1111-1111-1111-111111111111')
ON CONFLICT (email) DO NOTHING;
