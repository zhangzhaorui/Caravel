FROM registry.dataos.io/library/ubuntu:14.04
RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.aliyun.com/g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y build-essential libssl-dev libffi-dev python-dev python-pip libmysqlclient-dev && \
    apt-get build-dep -y psycopg2 && \
    pip install psycopg2==2.6.1 && \
    pip install sqlalchemy-redshift==0.5.0 && \
    pip install caravel==0.9.0 && \
    pip install mysqlclient==1.3.7 && \
    pip install pandas==0.18.0
ENV ROW_LIMIT=5000 \
    WEBSERVER_THREADS=8 \
    SECRET_KEY=\2\1thisismyscretkey\1\2\e\y\y\h \
    CSRF_ENABLED=1 \
    DEBUG=1 \
    PYTHONPATH=/home/caravel/caravel_config.py:$PYTHONPATH
EXPOSE 8088
WORKDIR /home/caravel
COPY . /home/caravel
RUN /bin/chmod +x /home/caravel/start.sh
CMD /home/caravel/start.sh
