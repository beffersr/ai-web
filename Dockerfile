FROM centos:7

LABEL maintainer="rob.beffers@rivm.nl"
ENV TZ Europe/Amsterdam

RUN yum -y install epel-release
RUN yum -y install python3 python3-pip
RUN pip3 install -U pip
RUN pip3 install -U virtualenv
RUN virtualenv -p python3 /ai-env
RUN cd /ai-env
RUN source /ai-env/bin/activate
RUN pip install --upgrade tensorflow
RUN yum -y install django
RUN django-admin startproject ai_project
RUN cd /ai_project
RUN python /ai_project/manage.py migrate
#RUN python /ai_project/manage.py createsuperuser
# Creeer superuser door dit commando op de terminal in de POD uit te voeren!!
EXPOSE 8000
RUN echo -e "\nALLOWED_HOSTS.append('*')" >> /ai_project/ai_project/settings.py
RUN python /ai_project/manage.py startapp ai_app
COPY ai_app/. /ai_app
COPY ai_project /ai_project/ai_project
CMD python /ai_project/manage.py runserver 0.0.0.0:8000
# CMD while true; do sleep 5 ; done
