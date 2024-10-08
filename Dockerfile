FROM debian:12

WORKDIR /opt/openconncect

COPY ./ca.tmpl /opt/openconncect/ca.tmpl
COPY ./server.tmpl /opt/openconncect/server.tmpl
COPY ./run.sh /opt/openconncect/run.sh

RUN apt-get update && apt-get install -y gnutls-bin iptables iproute2 iputils-ping wget libgnutls28-dev libev-dev build-essential pkg-config libgnutls28-dev libreadline-dev libseccomp-dev libwrap0-dev libnl-nf-3-dev liblz4-dev certbot && \
    wget ftp://ftp.infradead.org/pub/ocserv/ocserv-1.2.1.tar.xz && \
    tar xvf ocserv-1.2.1.tar.xz && cd ocserv-1.2.1 && \
    ./configure && \
    make && make install && \
    cd /opt/openconncect && \
    rm -rf /opt/openconncect/ocserv-1.2.1 && \
    mkdir /etc/ocserv &&  useradd ocserv && \
    certtool --generate-privkey --outfile ca-key.pem && \
    certtool --generate-self-signed --load-privkey ca-key.pem --template ca.tmpl --outfile ca-cert.pem  && \
    certtool --generate-privkey --outfile server-key.pem && \
    certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template server.tmpl --outfile server-cert.pem && \
    mv server-cert.pem server-key.pem /etc/ocserv/

COPY ./ocserv.conf /etc/ocserv/ocserv.conf
COPY ./passwd /etc/ocserv/passwd

CMD [ "/opt/openconncect/run.sh"]
