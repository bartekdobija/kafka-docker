#!/usr/bin/env bash

exec /opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties&
exec /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
