FROM python:slim

RUN apt-get update && apt install --no-install-recommends -y \
    gcc \
    python3-dev

WORKDIR /app

RUN --mount=type=cache,target=/root/.cache pip install poetry && \
    poetry config virtualenvs.create false

COPY pyproject.toml poetry.lock .

ARG DEV
RUN if [ "$DEV" = "true" ];  \
    then poetry install --only dev; \
fi  \
