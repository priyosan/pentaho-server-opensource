--
-- note: this script assumes pg_hba.conf is configured correctly
--

-- \connect postgres postgres
ALTER DATABASE hibernate  OWNER TO awsbiuser;

drop database if exists hibernate;
--drop user if exists hibuser;
drop role if exists hibuser;
--CREATE USER hibuser PASSWORD '@@hib_user_password@@';
CREATE role hibuser PASSWORD '@@hib_user_password@@' login;

CREATE DATABASE hibernate ENCODING = 'UTF8' TABLESPACE = pg_default;

ALTER DATABASE hibernate  OWNER TO hibuser;

GRANT ALL PRIVILEGES ON DATABASE hibernate to hibuser;
