DOCKER_COMPOSE = docker-compose -f ./docker/docker-compose.yml
DOCKER_COMPOSE_PHP_FPM_EXEC = ${DOCKER_COMPOSE} exec -u www-data php-fpm

build:
	${DOCKER_COMPOSE} build

up:
	${DOCKER_COMPOSE} up -d --remove-orphans

down:
	${DOCKER_COMPOSE} down --rmi=all --remove-orphans

start:
	${DOCKER_COMPOSE} start

stop:
	${DOCKER_COMPOSE} stop

exec:
	${DOCKER_COMPOSE} exec -it php-fpm bash

composer:
	${DOCKER_COMPOSE} exec php-fpm composer install
	
clean:
	${DOCKER_COMPOSE} down -v


# phpunit
test:
	${DOCKER_COMPOSE} exec php-fpm bin/phpunit


# database 
db_schema_validate:
	${DOCKER_COMPOSE} exec php-fpm bin/console doctrine:schema:validate

db_diff:
	${DOCKER_COMPOSE} exec php-fpm bin/console doctrine:migrations:diff --no-interaction

db_migrate:
	${DOCKER_COMPOSE} exec php-fpm bin/console doctrine:migrations:migrate --no-interaction

db_migrate_test:
	${DOCKER_COMPOSE} exec php-fpm bin/console doctrine:migrations:migrate --env="test" --no-interaction


# code style 
cs_fix:
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/php-cs-fixer fix

cs_fix_diff:
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/php-cs-fixer fix --dry-run --diff


restart: stop start
rebuild: down build up