from adrianogam/alpine-java8-postgres9:latest

ENV ELASTIC_SEARCH_VERSION 5.6.15

RUN cd /tmp && \
  wget -O elastic_search.tar.gz "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_SEARCH_VERSION}.tar.gz" && \
  tar -xf elastic_search.tar.gz && \
  mv elasticsearch-$ELASTIC_SEARCH_VERSION /usr/share/elasticsearch && \
  echo -e 'network.host: 0.0.0.0\ndiscovery.zen.minimum_master_nodes: 1' > /usr/share/elasticsearch/config/elasticsearch.yml && \
  adduser -D -h /usr/share/elasticsearch elasticsearch && \
  chown -R elasticsearch:elasticsearch /usr/share/elasticsearch && \
  rm -rf /tmp/*

ENV PATH /usr/share/elasticsearch/bin:$PATH
EXPOSE 9200 9300

COPY joint_entrypoint.sh /joint_entrypoint.sh
ENTRYPOINT ["/joint_entrypoint.sh"]
CMD ["tail", "-f", "/joint_entrypoint.sh"]
