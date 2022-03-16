ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ARG ECOWITT2MQTT_VERSION

COPY rootfs /

RUN apk add --no-cache --virtual .build-dependencies \
    && pip3 install --no-cache ecowitt2mqtt==${ECOWITT2MQTT_VERSION} \
    && apk del .build-dependencies

RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

