#!/usr/bin/env sh
echo "dropping relations, resetting the database..."
heroku pg:reset DATABASE --confirm $HEROKU_APP
echo "reset the database"
echo "reseeding"
cat ".data/staging/init.staging.sql" | heroku pg:psql