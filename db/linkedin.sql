-- uncomment to reset database
-- DROP TABLE companies;
-- DROP TABLE skills;
-- DROP TABLE schools;
-- DROP TABLE profiles;

--	profiles
--
--	entity table for a LinkedIn user profile
--
--	id:      primary key
-- 	name:    user name
--	email:   user email
CREATE TABLE profiles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

--  schools
--
--  many-to-many relational table between profiles and schools
--
--  id:             primary key
--  p_id:           profile id
--  name:           school degree
--  degree:         school degree
--  start_date:     degree start date
--  end_date        degree end date
CREATE TABLE schools (
    id SERIAL PRIMARY KEY,
    p_id SERIAL REFERENCES profiles(id),
    name VARCHAR(255) NOT NULL,
    degree VARCHAR(255) NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    UNIQUE (p_id, name, degree)
);

--  companies
--
--  many-to-many relational table between profiles and companies
--
--  id:             primary key
--  p_id:           profile id
--  name:           company name
--  title:          position title
--  is_current:     t/f for current held employment
--  start_date:     start date in mm/yy
--  end_date:       end date in mm/yy
--  summary:        position summary
CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    p_id SERIAL REFERENCES profiles(id),
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL,
    is_current BOOLEAN NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    summary VARCHAR(1500),
    UNIQUE (p_id, name, position)
);

--  skills
--
--  many-to-many relational table between profiles and skills
--
--  id:     primary key
--  p_id:   profile id
--  name:   skill name
CREATE TABLE skills (
    id SERIAL PRIMARY KEY,
    p_id SERIAL REFERENCES profiles(id),
    name VARCHAR(255) NOT NULL,
    UNIQUE (p_id, name)
);

-- disallows certain operations on tables
CREATE RULE profiles_delete_protect AS ON DELETE TO profiles DO INSTEAD NOTHING;
CREATE RULE profiles_update_protect AS ON UPDATE TO profiles DO INSTEAD NOTHING;
CREATE RULE companys_delete_protect AS ON DELETE TO companies DO INSTEAD NOTHING;
CREATE RULE companys_update_protect AS ON UPDATE TO companies DO INSTEAD NOTHING;
CREATE RULE skills_delete_protect AS ON DELETE TO skills DO INSTEAD NOTHING;
CREATE RULE skills_update_protect AS ON UPDATE TO skills DO INSTEAD NOTHING;
CREATE RULE schools_delete_protect AS ON DELETE TO schools DO INSTEAD NOTHING;
CREATE RULE schools_update_protect AS ON UPDATE TO schools DO INSTEAD NOTHING;
