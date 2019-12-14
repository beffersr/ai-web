# ******************  Onderstaande regel is nodig voor installatie obv Centos ********************
# FROM centos:7
# ************************************************************************************************
# ******************  Onderstaande regel is nodig voor installatie obv RHEL **********************
FROM rhel
# ************************************************************************************************

LABEL maintainer="rob.beffers@rivm.nl"
ENV TZ Europe/Amsterdam

RUN yum install -y git gcc python-virtualenv
COPY etc/ontwikkel.sh /var/ontwikkel.sh
RUN chmod a+x /var/ontwikkel.sh

# Instaleren van lighttpd
RUN yum install -y lighttpd
RUN yum install -y lighttpd-fastcgi

# lighttpd werkt op poort 8080 (zie ook lighttpd.conf)
EXPOSE 8080


RUN mkdir /opt/ai-web
# sudo yum -y install https://yum.postgresql.org/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm
# sudo yum -y install postgresql96-server postgresql96-contrib postgresql96-devel
# sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
# sudo systemctl start postgresql-9.6
# sudo systemctl enable postgresql-9.6
# sudo su - postgres
# createuser u_urban
# psql -c "ALTER USER u_urban WITH PASSWORD '123';"
# createdb --owner u_urban urban_prod
# NOG IETS
# sudo su - urbantrain
RUN virtualenv venv
RUN source venv/bin/activate
RUN mkdir logs
# https://github.com/beffersr/ai-web.git
RUN git clone git@github.com:beffersr/ai-web.git

# export PATH=$PATH:/usr/pgsql-9.6/bin/
# pip install pip --upgrade
# pip install -r requirements.txt


# KOPIEREN VAN FILES
# de files uit de map gisportal moeten naar de root van lighttpd worden gekopieerd
RUN mkdir -p /var/www/html/ai-web/ai-web
COPY ai-web/. /var/www/html/ai-web/ai-web
# de files uit de map etc moeten naar verschillende mappen worden gekopieerd (soms met andere naam!)
COPY etc/umask-ai-map.sh /etc/umask-ai-map.sh
COPY etc/lighttpd.conf /etc/lighttpd.conf

# ******************  Onderstaande regels zijn nodig voor installatie obv RHEL *******************
# COPY etc/modules.conf /etc/lighttpd/modules.conf
# ************************************************************************************************

# Het starten van de lighttpd service gebeurt via het umask-ai-map.sh script; Deze zet de rechten
# op ai-map goed en start vervolgens de lighttpd service.
RUN chmod +x /etc/umask-ai-map.sh
CMD /etc/umask-ai-map.sh
