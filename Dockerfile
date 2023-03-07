FROM python:3.11.1-alpine3.17 as base
ENV PYTHONUNBUFFERED=true
WORKDIR /app

ENV POETRY_HOME=/opt/poetry
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV PATH="$POETRY_HOME/bin:$PATH"
ARG POETRY_VERSION=1.3.1

# If we are buildling on arm64 (mac docker) then we need some extra packages
ARG BUILDPLATFORM
RUN if [ "${BUILDPLATFORM}" = "linux/arm64" ]; then \
        apk add gcc libc-dev libffi-dev; \
    fi

RUN python -c 'from urllib.request import urlopen; print(urlopen("https://install.python-poetry.org").read().decode())' | python3 -

# Copy project metadata
COPY README.md pyproject.toml poetry.lock ./

RUN apk add libgcc
# RUN apk add nodejs  # There's a bug in python-pyright that requires two versions of nodejs
RUN poetry install --no-interaction --no-ansi -vvv --no-root --only pyright

RUN poetry run pyright
