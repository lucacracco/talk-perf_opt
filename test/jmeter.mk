SCRIPT_DIR ?= ./scripts
JMX ?= test.jmx
JMETER_DIR ?= ./../apache-jmeter/bin
REPORT_DIR ?= ./reports/

jmeter-run: ## Run test.
	@echo "Run test '${JMX}'"
	${SCRIPT_DIR}/run-jmeter.sh -j=${JMX} -d=${JMETER_DIR} -r=${REPORT_DIR}

jmeter-gui: ## Run gui.
	@echo "Run gui"
	${SCRIPT_DIR}/jmeter-gui.sh -j=${JMX} -d=${JMETER_DIR}

jmeter-download: ## Downlaod Apache JMeter binaries.
	@echo "Downlaod Apache JMeter binaries"
	${SCRIPT_DIR}/jmeter-download.sh -d=${JMETER_DIR}

jmeter-remove: ## Downlaod Apache JMeter binaries.
	@echo "Remove Apache JMeter binaries (${JMETER_DIR})"
	@rm -rf ${JMETER_DIR}

jmeter-docker-run: ## Run JMeter test with docker image.
	@echo "Download last docker justb4/jmeter image"
	@docker pull justb4/jmeter
	@echo "Run JMeter test with docker image"
	${SCRIPT_DIR}/run-jmeter-docker -j=${JMX} -r=${REPORT_DIR}

jmeter-clear-report: ## Clear report dir.
	@echo "Remove dir reports (${REPORT_DIR})"
	@rm -rf ${REPORT_DIR}