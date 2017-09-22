# Ubuntu image
#
# Version 0.1

# Pull from Ubuntu


FROM ubuntu:latest

MAINTAINER Wellington Marinho wpmarinho@globo.com

# avoid debconf and initrd
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc 
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. 
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list


RUN apt-get update && apt-get install python-software-properties software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 -y -q


# upgrade distro
RUN locale-gen en_US en_US.UTF-8
RUN apt-get update && apt-get upgrade -y
RUN apt-get install lsb-release -y
RUN ls -ltraR /var/lib/postgresql
RUN chown -R postgres:postgres /var/lib/postgresql/*

# clean packages
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*


USER postgres

RUN /etc/init.d/postgresql start &&\
    psql --command "update pg_database set encoding = 6, datcollate = 'en_US.UTF8', datctype = 'en_US.UTF8' where datname = 'template0';" &&\
    psql --command "update pg_database set encoding = 6, datcollate = 'en_US.UTF8', datctype = 'en_US.UTF8' where datname = 'template1';" &&\
    psql --command "update pg_database set encoding = 6, datcollate = 'en_US.UTF8', datctype = 'en_US.UTF8' where datname = 'postgres';" &&\
    psql --command "CREATE USER pgadmin WITH SUPERUSER PASSWORD 'pgadmin.';"

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf && echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
