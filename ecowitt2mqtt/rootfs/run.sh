#!/usr/bin/with-contenv bashio
SCRIPT_ARGUMENTS=()

LOGGING=$(bashio::info 'hassio.info.logging' '.logging')
bashio::log.level "${LOGGING}"

bashio::log.info "Fetching configuration..."

if ! bashio::config.exists 'mqtt_broker'; then
	bashio::log.info "MQTT server not found, auto-discovering..."
	MQTT_BROKER=$(bashio::services mqtt 'host')
	MQTT_PORT=$(bashio::services mqtt 'port')
else
	bashio::log.info "MQTT service found, fetching server detail..."
	MQTT_BROKER=$(bashio::config 'mqtt_broker')
	MQTT_PORT=$(bashio::config 'mqtt_port')
fi
	bashio::log.info "MQTT broker: '$MQTT_BROKER'"
	bashio::log.info "MQTT port: $MQTT_PORT"

if ! bashio::config.has_value 'mqtt_username'; then
	bashio::log.info "MQTT credentials not found, auto-discovering..."
	MQTT_USERNAME=$(bashio::services mqtt 'username')
	MQTT_PASSWORD=$(bashio::services mqtt 'password')
else
	bashio::log.info "MQTT credentials found, fetching..."
	MQTT_USERNAME=$(bashio::config 'mqtt_username')
	MQTT_PASSWORD=$(bashio::config 'mqtt_password')
fi
bashio::log.info "MQTT user: '$MQTT_USERNAME'"

if bashio::config.has_value 'mqtt_topic'; then
  MQTT_TOPIC=$(bashio::config "mqtt_topic")
  bashio::log.info "MQTT topic: '$MQTT_TOPIC'"
fi
  

#if bashio::config.has_value 'hass_discovery'; then
#  HASS_DISCOVERY=$(bashio::config "hass_discovery")
#  bashio::log.info "HASS_DISCOVERY: $HASS_DISCOVERY"
#  if [ "$HASS_DISCOVERY" == "true" ] && [ bashio::config.has_value 'hass_discovery_prefix' ]; then
#    HASS_DISCOVERY_PREFIX=$(bashio::config 'hass_discovery_prefix')
#    bashio::log.info "HASS discovery prefix: $HASS_DISCOVERY_PREFIX"
#  fi
#fi

if bashio::config.has_value 'log_level'; then
  LOG_LEVEL=$(bashio::config 'log_level')
else
  LOG_LEVEL=$LOGGING
fi
  bashio::log.info "Log level: $LOG_LEVEL"

if bashio::config.has_value 'input_unit_system'; then
  INPUT_UNIT_SYSTEM=$(bashio::config 'input_unit_system')
else
  INPUT_UNIT_SYSTEM="imperial"
fi
  bashio::log.info "Input Unit System: '$INPUT_UNIT_SYSTEM'"

if bashio::config.has_value 'output_unit_system'; then
  OUTPUT_UNIT_SYSTEM=$(bashio::config 'output_unit_system')
else
  OUTPUT_UNIT_SYSTEM="metric"
fi
  bashio::log.info "Output unit system: '$OUTPUT_UNIT_SYSTEM'"


# Boot up
bashio::log.info "Starting Ecowitt2MQTT"
ecowitt2mqtt \
	--log-level=${LOG_LEVEL} \
    --mqtt-broker=${MQTT_BROKER} \
    --mqtt-port=${MQTT_PORT} \
    --mqtt-username=${MQTT_USERNAME} \
    --mqtt-password=${MQTT_PASSWORD} \
	--mqtt-topic=${MQTT_TOPIC} \
	--hass-discovery \
    --input-unit-system=${INPUT_UNIT_SYSTEM} \
	--output-unit-system=${OUTPUT_UNIT_SYSTEM} 
	
	


