#!/bin/bash

touch log_postgres && touch log_search
docker-entrypoint.sh postgres > log_postgres &
su-exec elasticsearch elasticsearch > log_search &
grep -q 'PostgreSQL init process complete' <(tail -f log_postgres)
cat log_postgres
echo -e "\n\n\n\n-----------------\n\n\n\n"
grep -q -E 'started|bootstrap checks failed' <(tail -f log_search)
grep 'is too low' log_search && \
	echo 'Run in your host machine: sudo sysctl -w vm.max_map_count=262144' && exit 1
cat log_search
echo -e "\n\n\n\n-----------------\n\n\n\n"
echo 'Postgres and ElasticSearch should be ready by now!'
$@
echo 'End'
