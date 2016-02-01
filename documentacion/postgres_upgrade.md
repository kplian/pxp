PXP Postgres Upgrade (E.g.: Version 9.3 to 9.5 )
==============================================

1. Install postgres repository

  ```
  wget http://yum.postgresql.org/9.5/redhat/rhel-6-x86_64/pgdg-centos95-9.5-2.noarch.rpm
  rpm -ivh ./pgdg-centos95-9.5-2.noarch.rpm
  ```

2. List currently installed packages for 9.3 version

  ```
  rpm -qa | grep postgre | grep 93
  ```

3. List available packages for 9.5 version

  ```
  yum list postgres* | grep 95
  ```

4.  If all packages are available... install

  ```
  yum install postgresql95-pltcl.x86_64 postgresql95-plperl.x86_64 postgresql95-docs.x86_64  postgresql95-server.x86_64 postgresql95-plpython.x86_64 postgresql95.x86_64 postgresql95-contrib.x86_64 postgresql95-devel.x86_64 postgresql95-libs.x86_64 postgresql95-test.x86_64
  ```

5. Init database

  ```
  /etc/init.d/postgresql-9.5 initdb
  ```

6. Create pxp.so file for logs (only if you have a pxp database)

  ```
  gcc -I /usr/local/include -I /usr/pgsql-9.5/include/server/ -fpic -c /usr/local/lib/phx.c
  gcc -I /usr/local/include -I /usr/pgsql-9.0/include/server/ -shared -o phx.so phx.o
  ```

7. Upgrade as postgres user at /tmp folder

  ```
  /usr/pgsql-9.5/bin/pg_upgrade -v -b /usr/pgsql-9.3/bin/ -B /usr/pgsql-9.5/bin/ -d /var/lib/pgsql/9.3/data/ -D              /var/lib/pgsql/9.5/data/
  ```
Options are:

  ```
  -b   old postgresql binary directory
  -B   new postgresql binary directory
  -d   old postgresql data directory
  -D   new postgresql data directory
  ```

8. copy pg_hba.conf from old version

  ```
  cp /var/lib/pgsql/9.3/data/pg_hba.conf /var/lib/pgsql/9.5/data/pg_hba.conf
  ```
9. Config postgresql.conf file. To find differences between 9.3 and 9.5 config files you can use:

  ```
  diff /var/lib/pgsql/9.3/data/postgresql.conf /var/lib/pgsql/9.5/data/postgresql.conf
  ```

10. Start Service

  ```
  service postgresql-9.5 start
  ```

11. Generate minimal optimizer statistics (As postgres user)

  ```
  ./analyze_new_cluster.sh
  ```

12. **TEST IF EVERYTHING IS OK**

  **IF OK THEN...**

13. Remove old cluster (As postgres user)

  ```
  ./delete_old_cluster.sh
  ```

14. Remove old packages

  ```
  yum remove postgresql93-pltcl.x86_64 postgresql93-plperl.x86_64 postgresql93-docs.x86_64  postgresql93-server.x86_64    postgresql93-plpython.x86_64 postgresql93.x86_64 postgresql93-contrib.x86_64 postgresql93-devel.x86_64   postgresql93-libs.x86_64 postgresql93-test.x86_64
  ```
