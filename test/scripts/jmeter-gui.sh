#!/usr/bin/env bash

JMX=jmeter.jmx
JMETER_DIR=./apache-jmeter

for i in "$@"
do
case $i in
    -j=*|--jmx=*)
    JMX="${i#*=}"
    shift # past argument=value
    ;;
    -d=*|--jmeter_dir=*)
    JMETER_DIR="${i#*=}"
    shift # past argument=value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument with no value
    ;;
    *)
          # unknown option
    ;;
esac
done

${JMETER_DIR}/bin/jmeter.sh -t ${JMX}