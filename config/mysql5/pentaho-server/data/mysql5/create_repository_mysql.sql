CREATE DATABASE IF NOT EXISTS `hibernate` DEFAULT CHARACTER SET latin1;

USE hibernate;

GRANT ALL ON hibernate.* TO 'hibuser'@'localhost' identified by '@@hib_user_password@@'; 
GRANT ALL ON hibernate.* TO 'hibuser'@'%' identified by '@@hib_user_password@@'; 

commit;
