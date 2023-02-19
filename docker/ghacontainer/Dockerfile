ARG PYTHON_VERSION=3.11-slim-bullseye
FROM python:${PYTHON_VERSION}

ARG USER=runner
ARG USER_UID=1000
ARG USER_GID=1000
RUN addgroup --gid ${USER_GID} ${USER}
RUN adduser --disabled-password --gecos Runner --gid ${USER_GID} --shell /bin/bash --uid ${USER_UID} $USER

COPY docker/gunicorn/installPackagesGdal.sh /tmp/installPackages.sh
RUN bash /tmp/installPackages.sh && rm /tmp/installPackages.sh
