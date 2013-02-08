#!/bin/sh

#stopgf.sh

rm -f target/*.war

mvn package

#startgf.sh --debug

asadmin set configs.config.server-config.network-config.network-listeners.network-listener.http-listener-2.enabled=true
asadmin set configs.config.server-config.network-config.protocols.protocol.http-listener-2.http.websockets-support-enabled=true

asadmin deploy --force target/grizzly-websockets-chat.war

#open http://localhost:8080/grizzly-websockets-chat
