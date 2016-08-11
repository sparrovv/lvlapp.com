## How to setup postgreSQL on OSX?

```sh
brew install postgresql

To have launchd start postgresql at login:
    ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
Then to load postgresql now:
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

```

```sh
# To crate user:
createuser lvlapp_user

# Create DBs:
createdb -Olvlapp_user -Eutf8 lvlapp_development
createdb -Olvlapp_user -Eutf8 lvlapp_test

# test if you can connect:
psql -U lvlapp_user lvlapp_development

# to exit psql shell: Ctrl+d
```


## Migrating from MYSQL to POSTGRESQL

dump DB:

```sh
mysqldump -u user -p --compatible=postgresql --default-character-set=utf8 lvlapp_production > mysqltopsql.sql
```

Even though mysqldump has a `compatible` option it still requires conversion to postgreSQL friendly SQL.

To do this use: https://github.com/lanyrd/mysql-postgresql-converter

```sh
# convert
python db_converter.py mysqltopsql.sql lvlapp.psql

# load
psql -U lvlapp_user lvlapp_db -f lvlapp.psql
```
