FROM talkincode/pypy
MAINTAINER jamiesun <jamiesun.net@gmail.com>

RUN useradd -m -s /bin/bash nagios && \
    groupadd nagcmd && \
    usermod -a -G nagcmd nagios 

RUN apt-get update -y && \
    rm -rf /var/lib/apt/lists/*

RUN cd /usr/local/src && \
    wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.0.8.tar.gz && \
    tar xzf nagios-4.0.8.tar.gz && \
    cd /usr/local/src/nagios-4.0.8 && \
    ./configure --prefix=/usr/local/nagios && \
    make && \
    make install && \
    make install-init && \
    make install-config && \
    make install-commandmode

RUN cd /usr/local/src && \
    wget http://www.nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz && \
    tar xvf nagios-plugins-2.1.1.tar.gz && \
    cd /usr/local/src/nagios-plugins-2.1.1 && \
    ./configure --with-nagios-user=nagios --with-nagios-group=nagios && \
    make && make install

RUN rm -fr /usr/local/src/*

RUN pypy -m  pip install --upgrade pip
RUN pypy -m  pip install Mako
RUN pypy -m  pip install Beaker
RUN pypy -m  pip install MarkupSafe
RUN pypy -m  pip install PyYAML
RUN pypy -m  pip install Twisted
RUN pypy -m  pip install treq
RUN pypy -m  pip install tablib
RUN pypy -m  pip install cyclone
RUN pypy -m  pip install six
RUN pypy -m  pip install autobahn
RUN pypy -m  pip install pycrypto
RUN pypy -m  pip install pyOpenSSL>=0.14
RUN pypy -m  pip install service_identity
RUN pypy -m  pip install MySQL-python
RUN pypy -m  pip install SQLAlchemy
RUN pypy -m  pip install msgpack-python
RUN pypy -m  pip install psutil
RUN pypy -m  pip install IPy

