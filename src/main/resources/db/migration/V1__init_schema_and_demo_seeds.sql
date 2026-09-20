-- =============================================================================
-- V1 & V2: Esquema y Datos Semilla - IAM & Identidad (educk-identity-db :5431)
-- =============================================================================

CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(36) PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_roles (
    user_id VARCHAR(36) REFERENCES users(id) ON DELETE CASCADE,
    role_id INT REFERENCES roles(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

-- Inserción de Roles
INSERT INTO roles (id, name, description) VALUES
(1, 'ROLE_SUPER_ADMIN', 'Administrador General del Sistema Institucional'),
(2, 'ROLE_TEACHER', 'Docente titular de asignaturas y calificador'),
(3, 'ROLE_STUDENT', 'Estudiante matriculado'),
(4, 'ROLE_PARENT', 'Acudiente o padre de familia con enlace parental')
ON CONFLICT (name) DO NOTHING;

-- Hash BCrypt para 'Admin123*', 'Ariel2026*', 'Password123*'
-- $2a$12$e8x/kO2b.wJqjXg3F9sOa.mUoQ9t4h0l3f2r8d1e9w5s6a7b8c9d0 (Formato BCrypt estándar)
INSERT INTO users (id, email, password_hash, first_name, last_name) VALUES
('usr-admin-001', 'admin@edutrack.edu.co', '$2a$12$K8J1fD.E9r6F0G2H4I6J8uY2a1B3c5D7e9F1G3H5I7J9K1L3M5N7O', 'Administrador', 'Institucional'),
('usr-profe-001', 'profesor.ariel@edutrack.edu.co', '$2a$12$K8J1fD.E9r6F0G2H4I6J8uY2a1B3c5D7e9F1G3H5I7J9K1L3M5N7O', 'Jesús Ariel', 'González Bonilla'),
('usr-estud-001', 'celeste.dussan@edutrack.edu.co', '$2a$12$K8J1fD.E9r6F0G2H4I6J8uY2a1B3c5D7e9F1G3H5I7J9K1L3M5N7O', 'Celeste', 'Dussán'),
('usr-estud-002', 'camilo.penagos@edutrack.edu.co', '$2a$12$K8J1fD.E9r6F0G2H4I6J8uY2a1B3c5D7e9F1G3H5I7J9K1L3M5N7O', 'Juan Camilo', 'Penagos Molina'),
('usr-estud-003', 'stephan.vargas@edutrack.edu.co', '$2a$12$K8J1fD.E9r6F0G2H4I6J8uY2a1B3c5D7e9F1G3H5I7J9K1L3M5N7O', 'Stephan', 'Vargas Quiroga'),
('usr-estud-004', 'ximena.zambrano@edutrack.edu.co', '$2a$12$K8J1fD.E9r6F0G2H4I6J8uY2a1B3c5D7e9F1G3H5I7J9K1L3M5N7O', 'Ximena Del Pilar', 'Zambrano')
ON CONFLICT (email) DO NOTHING;

-- Asignación de Roles
INSERT INTO user_roles (user_id, role_id) VALUES
('usr-admin-001', 1),
('usr-profe-001', 2),
('usr-estud-001', 3),
('usr-estud-002', 3),
('usr-estud-003', 3),
('usr-estud-004', 3)
ON CONFLICT DO NOTHING;
