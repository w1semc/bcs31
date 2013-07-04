# Template Baltic IT

## Деплой
см. [DEPLOY.md](DEPLOY.md)

## Default database.yml:
```yaml
development:
  adapter: mysql2
  encoding: utf8
  database: balticit_dev
  username: root
  password: ''

test: &test
  adapter: mysql2
  encoding: utf8
  database: balticit_test
  username: root
  password: ''

production:
  adapter: mysql2
  encoding: utf8
  database: balticit_prod
  username: root
  password: ''

cucumber:
  <<: *test
```
