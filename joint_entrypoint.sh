#!/bin/bash

docker-entrypoint.sh postgres > log_postgres &
su-exec elasticsearch elasticsearch > log_search &
grep -q 'PostgreSQL init process complete' <(tail -f log_postgres)
cat log_postgres
echo -e "\n\n\n\n-----------------\n\n\n\n"
grep -q 'started' <(tail -f log_search)
cat log_search
echo -e "\n\n\n\n-----------------\n\n\n\n"
echo 'Postgres and ElasticSearch should be ready by now!'
$@
echo 'End'
