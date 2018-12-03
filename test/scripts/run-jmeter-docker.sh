#!/bin/bash

# Use JMeter Docker image.
JMETER_JMX=${1:-jmeter.jmx}
IMAGE="justb4/jmeter"
NET="NET" # `docker net list` for view all network in host.
R_DIR=./reports

# Reporting dir: start fresh.
echo "==== Reporting dir: start fresh ===="

sudo rm -rf ${R_DIR}
sudo mkdir -p ${R_DIR}
sudo rm -f ${JMETER_JMX}.jtl ${JMETER_JMX}.log

echo "==== Run jmeter instance ===="
#@todo found method to read env file and pass to jmeter!
docker stop ${JMETER_JMX} > /dev/null 2>&1
docker rm ${JMETER_JMX} > /dev/null 2>&1
docker run --name ${JMETER_JMX} --net=${NET} -i -v ${PWD}:${PWD} -w ${PWD} ${IMAGE} -Dlog_level.jmeter=DEBUG \
    -n -t ${JMETER_JMX}.jmx -l ${R_DIR}/log/${JMETER_JMX}.jtl -j ${R_DIR}/log/${JMETER_JMX}.log \
    -e -o ${R_DIR}/output
docker rm ${JMETER_JMX} > /dev/null 2>&1

# Set permission folder and files report.
UID=$(id -u)
GID=$(id -g)
sudo chmod -R 775 ${R_DIR}
sudo chown ${UID}:${GID} ${R_DIR}

echo "==== JMeter Log ===="
#cat ${R_DIR}/log/${NAME}.log

echo "==== Raw Test Report ===="
#cat ${R_DIR}/log/test-plan.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in file:"$(realpath "${R_DIR}")"/output/index.html"
