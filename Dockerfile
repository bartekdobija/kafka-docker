FROM openjdk:8
ARG kafka_version=2.4.1
ARG kafka_link=/opt/kafka
ADD entrypoint.sh /entrypoint.sh
RUN KAFKA_HOST=$(ip a s eth0 | awk '/inet/ {split($2, a,"/"); print a[1]}') \
  && wget http://ftp.man.poznan.pl/apache/kafka/${kafka_version}/kafka_2.13-${kafka_version}.tgz -q -P /tmp/ \
  && tar zxf /tmp/kafka_2.13-${kafka_version}.tgz -C /opt/ \
  && ln -f -s /opt/kafka_2.13-${kafka_version} ${kafka_link} \
  && echo "PATH=\\${PATH}:${kafka_link}/bin" > /etc/profile.d/kafka.sh \
  && echo "advertised.host.name=${KAFKA_HOST}" >> ${kafka_link}/config/server.properties \
  && sed -i "s/localhost/${KAFKA_HOST}/g" ${kafka_link}/config/producer.properties \
  && mkdir -p ${kafka_link}/logs \
  && chmod 744 /entrypoint.sh 

CMD [ "/entrypoint.sh" ]