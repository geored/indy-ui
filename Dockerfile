FROM georgy/maven:latest AS BUILDER

WORKDIR /opt/indy

ADD . /opt/indy

RUN mvn clean -DskipTests=true install && \
    cd deployments/launcher/target && \
    tar -xvf indy-launcher-1.7.4-SNAPSHOT-complete.tar.gz


FROM georgy/node8:latest

COPY --from=BUILDER /opt/indy/deployments/launcher/target/indy /opt/indy.ui/indy

RUN chgrp -R 0 /opt/indy.ui && \
    chmod -R g=u /opt/indy.ui && \
    cd /opt/indy.ui/indy/var/lib/indy/ui && \
    npm install -g http-server

WORKDIR /opt/indy.ui/indy/var/lib/indy/ui
EXPOSE 8000
CMD http-server --proxy http://indy-perf:8080 --cors -p 8000
