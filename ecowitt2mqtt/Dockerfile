ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ARG ECOWITT2MQTT_VERSION

COPY rootfs /

RUN apk add --no-cache --virtual .build-dependencies \
        gcc \
        python3-dev \
        libc-dev \
        musl-dev \
    && python3 -m ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools \
    && pip3 install --no-cache ecowitt2mqtt==${ECOWITT2MQTT_VERSION} \
    && apk del .build-dependencies

RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

