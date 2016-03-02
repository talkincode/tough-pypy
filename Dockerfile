FROM talkincode/pypy
MAINTAINER jamiesun <jamiesun.net@gmail.com>

RUN useradd -m -s /bin/bash nagios && \
    groupadd nagcmd && \
    usermod -a -G nagcmd nagios 

RUN apt-get update -y && \
    rm -rf /var/lib/apt/lists/*

RUN cd /usr/local/src && \
    wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz && \
    tar xzf nagios-4.1.1.tar.gz && \
    cd /usr/local/src/nagios-4.1.1 && \
    ./configure --prefix=/usr/local/nagios \
    --with-nagios-group=nagios \
    --with-command-group=nagcmd  && \
    make all && \
    make install && \
    make install-init && \
    make install-config && \
    make install-commandmode && \
    ln -s /usr/local/nagios/bin/nagios /usr/local/bin/nagios

RUN cd /usr/local/src && \
    wget http://www.nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz && \
    tar xvf nagios-plugins-2.1.1.tar.gz && \
    cd /usr/local/src/nagios-plugins-2.1.1 && \
    ./configure --with-nagios-user=nagios --with-nagios-group=nagios && \
    make && make install

RUN cd /usr/local/src && \
    wget http://iweb.dl.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz && \
    tar xvf nrpe-2.15.tar.gz && \
    cd /usr/local/src/nrpe-2.15 && \
    ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib/libssl.so && \
    ./configure --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib && \
    make all && \
    make install

RUN cd /usr/local/src && \
    wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1404-3.2.3.tgz && \
    tar xvf mongodb-linux-x86_64-ubuntu1404-3.2.3.tgz && \
    \cp /usr/local/src/mongodb-linux-x86_64-ubuntu1404-3.2.3/bin/* /usr/local/bin/

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
RUN pypy -m  pip install SQLAlchemy
RUN pypy -m  pip install msgpack-python
RUN pypy -m  pip install psutil
RUN pypy -m  pip install IPy
RUN pypy -m  pip install pynag
RUN pypy -m  pip install pymongo

