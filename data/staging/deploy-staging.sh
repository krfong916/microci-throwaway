#!/usr/bin/env bash
echo `pwd`
if [[ $(cat ./data/staging/init.staging.check.sql | heroku pg:psql) ]]; then
echo "schema and data exists, dropping relations..."
  [[ $(cat ./data/staging/init.staging.drop.sql | heroku pg:psql) ]];
  echo "relations dropped!"
  exit 1
else
  echo "schema and data do not exist, seeding..."
  [[ $(cat ./data/staging/init.staging.sql | heroku pg:psql) ]];
  echo "seeded!"
  exit 1
fi
