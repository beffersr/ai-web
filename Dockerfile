FROM centos:7

LABEL maintainer="rob.beffers@rivm.nl"
ENV TZ Europe/Amsterdam

RUN yum install -y git gcc python-virtualenv

RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y install python36u
RUN yum -y install python36u-pip
RUN yum -y install python36u-devel

RUN mkdir tensorflow_env
RUN cd tensorflow_env
RUN python3.6 -m venv my_tensorflow

RUN source my_tensorflow/bin/activate

RUN pip3 install --upgrade tensorflow

EXPOSE 5000

COPY etc/umask-ai-map.sh /etc/umask-ai-map.sh
RUN chmod +x /etc/umask-ai-map.sh
RUN /etc/umask-ai-map.sh

CMD while true; do sleep 5 ; done
