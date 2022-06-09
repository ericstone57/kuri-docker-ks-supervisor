FROM registry.cn-shanghai.aliyuncs.com/kuri/kuri-docker-uvicorn-gunicorn:latest

LABEL maintainer="Eric Lee <ericstone.dev@gmail.com>"

# Build depends
RUN install_packages curl \
	gcc \
	libc6-dev \
	autoconf \
	make \
	python3-dev \
	default-libmysqlclient-dev \
	build-essential

# Copy poetry.lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./poetry.lock* /app/

# Allow installing dev dependencies to run tests
ARG INSTALL_DEV=true
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --no-root ; else poetry install --no-root --no-dev ; fi"

# Supervisor
COPY ./supervisord.conf /app/supervisor/supervisord.conf
COPY ./start-supervisor.sh /start-supervisor
RUN chmod +x /start-supervisor

ENV PYTHONPATH=/app
