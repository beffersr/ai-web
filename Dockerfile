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
EXPOSE 8000

# CMD python /ai_project/manage.py runserver 0.0.0.0:8000

#


# COPY etc/umask-ai-map.sh /etc/umask-ai-map.sh
# RUN chmod +x /etc/umask-ai-map.sh
# RUN /etc/umask-ai-map.sh
CMD while true; do sleep 5 ; done
