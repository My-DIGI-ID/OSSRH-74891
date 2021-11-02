FROM bcgovimages/von-image:py36-1.15-0

USER root

ENV ACAPY_OUTBOUND_TRANSPORT http

RUN apt-get update && \
    apt-get upgrade -y &&  \
    apt-get -qq -y install jq

USER 1001

ENV ENABLE_PTVSD 0

RUN git clone https://github.com/hyperledger/aries-cloudagent-python.git

RUN cd aries-cloudagent-python && git checkout tags/0.6.0

RUN pip3 install --no-cache-dir -r aries-cloudagent-python/requirements.txt -r aries-cloudagent-python/requirements.dev.txt && \
    pip3 install --no-cache-dir -e aries-cloudagent-python
RUN mkdir logs && chown -R indy:indy logs && chmod -R ug+rw logs

EXPOSE 10080 11000

ENTRYPOINT ["/bin/bash", "-c", "aca-py start --admin 0.0.0.0 10080 --inbound-transport http 0.0.0.0 11000"]
