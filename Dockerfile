FROM blockstream/esplora:electrs-latest
USER root
RUN apt-get update && apt-get install -y nginx libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libdb5.3++-dev libdb5.3++ libdb5.3-dev libzmq3-dev libminiupnpc-dev
#RUN wget -qO- https://bitcoincore.org/bin/bitcoin-core-26.0/bitcoin-26.0-x86_64-linux-gnu.tar.gz | tar -xzvf - -C /usr/local --strip-components=1

COPY ./doge/dogecoin-cli /usr/local/bin/
COPY ./doge/dogecoin-tx /usr/local/bin/
COPY ./doge/dogecoind /usr/local/bin/
RUN chmod +x /usr/local/bin/dogecoin-cli && chmod +x /usr/local/bin/dogecoin-tx && chmod +x /usr/local/bin/dogecoind
RUN cp -f /usr/local/bin/dogecoin-cli /usr/local/bin/bitcoin-cli && cp -f /usr/local/bin/dogecoin-tx /usr/local/bin/bitcoin-tx && cp -f /usr/local/bin/dogecoind /usr/local/bin/bitcoind


RUN rm /etc/nginx/nginx.conf
COPY ./nginx/nginx.conf /etc/nginx/

RUN rm /etc/nginx/sites-enabled/default
COPY ./nginx/sites-available /etc/nginx/sites-enabled/


COPY ./static /var/www/html/

COPY start.sh /app/
COPY start-app.sh /app/



RUN chmod +x /app/start.sh && chmod +x /app/start-app.sh && chown -R app:app /app

CMD ["bash", "/app/start.sh"]