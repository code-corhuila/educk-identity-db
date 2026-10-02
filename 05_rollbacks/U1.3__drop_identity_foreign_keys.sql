ALTER TABLE identity_schema.users DROP CONSTRAINT IF EXISTS fk_users_school;
ALTER TABLE identity_schema.students DROP CONSTRAINT IF EXISTS fk_students_school;
ALTER TABLE identity_schema.parent_child_link DROP CONSTRAINT IF EXISTS fk_pcl_parent;
ALTER TABLE identity_schema.parent_child_link DROP CONSTRAINT IF EXISTS fk_pcl_student;
ALTER TABLE identity_schema.refresh_tokens DROP CONSTRAINT IF EXISTS fk_rt_user;
