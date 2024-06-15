FROM python:slim

RUN apt-get update && apt install --no-install-recommends -y \
    gcc \
    curl \
    python3-dev

WORKDIR /app

# Install Poetry
RUN --mount=type=cache,target=/root/.cache pip install poetry && \
    poetry config virtualenvs.create false

# Install main dependencies
COPY pyproject.toml poetry.lock .
RUN --mount=type=cache,target=/root/.cache POETRY_CACHE_DIR=/root/.cache \
    poetry install --only main --no-root

# Install dev dependencies
ARG DEV
RUN if [ "$DEV" = "true" ];  \
    then poetry install --only dev; \
fi  \
