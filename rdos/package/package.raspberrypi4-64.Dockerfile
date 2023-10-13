FROM scratch

ARG ARTIFACT=raspberrypi4-64

LABEL maintainer="Deniz Hofmeister"
LABEL description="Robotics Deployment OS Packaging"

COPY ${ARTIFACT}/robotics-deployment-core-${ARTIFACT}-*.wic.bz2 /opt/rdos/

WORKDIR /opt/rdos