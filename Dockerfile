FROM antik486/centos71

MAINTAINER KERIM BEKBEROV <bekberovkerim@gmail.com>


RUN \
    yum -y update && \
    yum install -y http://yum.postgresql.org/9.4/redhat/rhel-7.1-x86_64/pgdg-centos94-9.4-2.noarch.rpm \
                   http://yum.postgresql.org/9.4/redhat/rhel-7.1-x86_64/postgresql94-libs-9.4.6-1PGDG.rhel7.x86_64.rpm \
                   http://yum.postgresql.org/9.4/redhat/rhel-7.1-x86_64/postgresql94-9.4.6-1PGDG.rhel7.x86_64.rpm \
                   http://yum.postgresql.org/9.4/redhat/rhel-7.1-x86_64/postgresql94-server-9.4.6-1PGDG.rhel7.x86_64.rpm \
                   http://yum.postgresql.org/9.4/redhat/rhel-7.1-x86_64/postgresql94-contrib-9.4.6-1PGDG.rhel7.x86_64.rpm  && \

        rm -r  /var/tmp/*  && \
        yum clean all      && \
        localedef -i ru_RU -f UTF-8 ru_RU.UTF-8


ENV PGDATA /var/lib/pgsql/data

RUN su - postgres -c "/usr/pgsql-9.4/bin/initdb -E UTF8 --lc-collate=ru_RU.UTF-8 --lc-ctype=ru_RU.UTF-8 -D $PGDATA"

RUN echo "host    all             all             0.0.0.0/0               md5" >> $PGDATA/pg_hba.conf

RUN echo "host    all             docker          0.0.0.0/0               trust" >> $PGDATA/pg_hba.conf

RUN echo "listen_addresses = '*'" >> $PGDATA/postgresql.conf

RUN echo "port = 5432" >> $PGDATA/postgresql.conf

RUN su - postgres -c "/usr/pgsql-9.4/bin/pg_ctl -w start -D $PGDATA \

                      && echo create role docker SUPERUSER LOGIN PASSWORD \'docker\' | psql \

                      && /usr/pgsql-9.4/bin/pg_ctl -w stop -D $PGDATA"


EXPOSE 5432


CMD ["su", "postgres", "-c", "/usr/pgsql-9.4/bin/postgres -i -c config_file=$PGDATA/postgresql.conf"]
