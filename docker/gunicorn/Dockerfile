# syntax=docker/dockerfile:latest

ARG APP_TYPE=build_image

FROM python:3.11-slim-bullseye AS app_base_image
ARG USER=runner
ARG USER_UID=1000
ARG USER_GID=1000
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt install --assume-yes --quiet gdal-bin \
    && apt --assume-yes --quiet autoremove \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
RUN addgroup --gid ${USER_GID} ${USER}
RUN adduser --disabled-password --gecos Runner --gid ${USER_GID} --shell /bin/bash --uid ${USER_UID} $USER
USER ${USER}
ENV USER=${USER}
ENV HOME="/home/${USER}"
ENV APP_HOME=${HOME}/app
ENV PATH="${HOME}/.local/bin:$PATH"
RUN mkdir ${APP_HOME}
WORKDIR ${HOME}
COPY <<EOF docker_command.sh
echo Not implemented
EOF

FROM app_base_image AS app_build_image
USER root
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt install --assume-yes --quiet curl git \
    && apt --assume-yes --quiet autoremove \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
USER ${USER}
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN poetry config virtualenvs.in-project true
COPY --chown=${USER_UID}:${USER_GID} . ${APP_HOME}
COPY <<EOF docker_command.sh
cd ${APP_HOME}
poetry install --with test
find .
pwd
poetry run pytest
EOF
RUN cat docker_command.sh



FROM app_${APP_TYPE} as app_final
CMD ["bash", "docker_command.sh"]

