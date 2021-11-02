FROM bcgovimages/von-image:next-1

USER root

RUN apt-get update && \
    apt-get upgrade -y 

USER 1001

RUN git clone https://github.com/bcgov/indy-tails-server.git

RUN pip3 install --no-cache-dir -r indy-tails-server/requirements.txt -r indy-tails-server/requirements.dev.txt
RUN pip3 install --no-cache-dir -e indy-tails-server

ENTRYPOINT ["/bin/bash", "-c", "tails-server --storage-path /home/indy/.indy_client --host $TAILS_SERVER_ADDRESS --log-level $TAILS_SERVER_LOG_LEVEL"]
