FROM python:3.10-alpine3.16
LABEL maintainer="harikrishnan51688@gmail.com"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY ./requirements.txt .
COPY ./scripts /app/scripts

RUN python -m venv /opt/env && \
    /opt/env/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev linux-headers && \
    /opt/env/bin/pip install -r requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app 
    # static and media files config
RUN chmod -R +x /app/scripts/run.sh
#     mkdir -p /app/main/staticfiles && \
#     mkdir -p /app/main/mediafiles && \
#     chmod -R 755 /app/main/staticfiles && \
#     chmod -R 755 /app/main/mediafiles

ENV PATH="/app/scripts:/opt/env/bin:$PATH"

COPY . .
USER app

CMD [ "run.sh" ]
