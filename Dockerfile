### Python build stage
FROM python:3.9-slim-buster

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PATH=./node_modules/.bin/:$PATH \
    IN_DOCKER=yes \
    IPYTHONDIR=/app/.ipython

RUN apt-get update \
  && apt-get install -y build-essential libpq-dev gettext \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/*

RUN addgroup --system django \
    && adduser --system --ingroup django django

WORKDIR /app

COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY --chown=django:django . /app/

# replace this line with whatever is needed to copy the built JS from your node container into the django server container
COPY --from=templateproject_node --chown=django:django /app/templateproject/frontend/static /app/templateproject/frontend/static

RUN ./manage.py collectstatic --noinput

### Python runtime stage

USER django

VOLUME /app
VOLUME /app/data
VOLUME /app/data/logs
VOLUME /app/data/static
VOLUME /app/data/media

ENV RELOAD_DIR=./templateproject \
    POSTGRES_HOST=postgres \
    POSTGRES_PORT=5432 \
    POSTGRES_DB=templateproject \
    POSTGRES_USER=templateproject \
    POSTGRES_PASSWORD=templateproject \
    HTTP_HOST=0.0.0.0 \
    HTTP_PORT=5000 \
    HTTP_WORKERS=4

# Production:
# CMD ["/usr/local/bin/gunicorn", "config.asgi", "--bind", "$HTTP_HOST:$HTTP_PORT", "--chdir=/app", "-k", "uvicorn.workers.UvicornWorker"]

# Development:
CMD ["/usr/local/bin/uvicorn", "config.asgi:application", "--host", "$HTTP_HOST", "--port", "$HTTP_PORT", "--workers", "$HTTP_WORKERS", "--reload", "--reload-dir=$RELOAD_DIR"]
