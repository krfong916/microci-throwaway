#!/usr/bin/env sh
echo `pwd`
if [[ $(cat "./data/staging/init.staging.check.sql" | heroku pg:psql) ]]; then
  echo "the schema and data exist, dropping relations..."
  [[ $(cat "./data/staging/init.staging.drop.sql" | heroku pg:psql) ]];
  echo "dropped relations"
  echo "reseeding"
  [[ $(cat "./data/staging/init.staging.sql" | heroku pg:psql) ]];
  echo "seeded"
  exit 1
else
  echo "the schema and data do not exist, seeding..."
  [[ $(cat "./data/staging/init.staging.sql" | heroku pg:psql) ]];
  echo "seeded"
  exit 1
fi
