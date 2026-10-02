ALTER TABLE identity_schema.users 
ADD CONSTRAINT fk_users_school FOREIGN KEY (school_id) REFERENCES identity_schema.schools(id);

ALTER TABLE identity_schema.students 
ADD CONSTRAINT fk_students_school FOREIGN KEY (school_id) REFERENCES identity_schema.schools(id);

ALTER TABLE identity_schema.parent_child_link 
ADD CONSTRAINT fk_pcl_parent FOREIGN KEY (parent_id) REFERENCES identity_schema.users(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_pcl_student FOREIGN KEY (student_id) REFERENCES identity_schema.students(id) ON DELETE CASCADE;

ALTER TABLE identity_schema.refresh_tokens 
ADD CONSTRAINT fk_rt_user FOREIGN KEY (user_id) REFERENCES identity_schema.users(id) ON DELETE CASCADE;
