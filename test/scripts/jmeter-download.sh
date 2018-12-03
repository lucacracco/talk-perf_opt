#!/usr/bin/env bash

# @todo get last binaries available?!
JMETER_BINARIES="http://mirror.nohup.it/apache//jmeter/binaries/apache-jmeter-5.0.zip"
JMETER_PLUGIN="https://github.com/NovatecConsulting/JMeter-InfluxDB-Writer/releases/download/v-1.2/JMeter-InfluxDB-Writer-plugin-1.2.jar"
JMETER_DIR="./apache-jmeter"

for i in "$@"
do
case $i in
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

if [ -d "${JMETER_DIR}" ]; then
    echo "==== Remove current dir ===="
    rm -rf ${JMETER_DIR}
fi

echo "==== Download zip with binaries and unzip ===="
wget ${JMETER_BINARIES} -O apache-jmeter-5.0.zip
unzip apache-jmeter-5.0.zip

# Remove zip downloaded.
rm apache-jmeter-5.0.zip

# Rename directory
mv apache-jmeter-5.0 ${JMETER_DIR}

echo "==== Download plugins ===="
wget ${JMETER_PLUGIN} -P ${JMETER_DIR}/lib/ext
