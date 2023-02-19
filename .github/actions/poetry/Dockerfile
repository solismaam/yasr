FROM python:3.11-slim-bullseye AS app_base
ARG USER=runner
ARG USER_UID=1000
ARG USER_GID=1000
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt install --assume-yes --quiet gdal-bin \
    && apt --assume-yes --quiet autoremove \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN poetry config virtualenvs.in-project true

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]