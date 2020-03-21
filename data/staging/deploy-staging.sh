#!/usr/bin/env sh
echo `pwd`
if [[ $(cat "./init.staging.check.sql" | heroku pg:psql) ]]; then
  echo "the schema and data exist, dropping relations..."
  [[ $(cat "./init.staging.drop.sql" | heroku pg:psql) ]];
  echo "dropped relations"
  echo "reseeding"
  [[ $(cat "./init.staging.sql" | heroku pg:psql) ]];
  echo "seeded"
  exit 1
else
  echo "the schema and data do not exist, seeding..."
  [[ $(cat "./init.staging.sql" | heroku pg:psql) ]];
  echo "seeded"
  exit 1
fi
