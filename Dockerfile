FROM centos:7

LABEL maintainer="rob.beffers@rivm.nl"
ENV TZ Europe/Amsterdam

RUN yum install -y git gcc python-virtualenv

RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y install python36u
RUN yum -y install python36u-pip
RUN yum -y install python36u-devel
RUN mkdir -p /ai-map/ai
RUN cd /ai-map/ai
RUN python3 -m venv /ai-map/ai

RUN source /ai-map/ai/bin/activate

RUN pip3 install --upgrade tensorflow

RUN yum -y install django

RUN django-admin startproject ai

RUN cd /ai

RUN python3 /ai/manage.py migrate

# RUN python3 /ai/manage.py createsuperuser
EXPOSE 8000

# CMD python3 /ai/manage.py runserver 0.0.0.0:8000

#


# COPY etc/umask-ai-map.sh /etc/umask-ai-map.sh
# RUN chmod +x /etc/umask-ai-map.sh
# RUN /etc/umask-ai-map.sh
CMD while true; do sleep 5 ; done
