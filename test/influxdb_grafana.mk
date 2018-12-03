DOCKER_COMPOSE_INFLUXDB_GRAFANA ?= ./scripts/influxdb-grafana.yml

influxdb-grafana-run: ## Run container with influxdb and grafana.
	@docker-compose -f ${DOCKER_COMPOSE_INFLUXDB_GRAFANA} pull
	@docker-compose -f ${DOCKER_COMPOSE_INFLUXDB_GRAFANA} up -d --remove-orphans
	@echo 'Create database in influxdb: curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE novatec"'
	@echo "Login to Grafana: http://localhost:3000 "
	@echo "Create 'novatec' datasource related to 'influxdb'"
	@echo "Download and use Dashboards: https://grafana.com/dashboards/1152 and set it in Grafana"

influxdb-grafana-stop: ## Stop container with influxdb and grafana.
	@docker-compose -f ${DOCKER_COMPOSE_INFLUXDB_GRAFANA} stop

influxdb-grafana-prune: ## Stop and remove container with influxdb and grafana.
	@docker-compose -f ${DOCKER_COMPOSE_INFLUXDB_GRAFANA} down -v