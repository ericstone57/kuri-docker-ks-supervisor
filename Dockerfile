FROM registry.cn-shanghai.aliyuncs.com/kuri/kuri-docker-uvicorn-gunicorn:latest

LABEL maintainer="Eric Lee <ericstone.dev@gmail.com>"

# Build depends
RUN install_packages curl \
	gcc \
	libc6-dev \
	autoconf \
	make

# Copy poetry.lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./poetry.lock* /app/

# Allow installing dev dependencies to run tests
ARG INSTALL_DEV=true
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --no-root ; else poetry install --no-root --no-dev ; fi"

ENV PYTHONPATH=/app
