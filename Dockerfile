FROM python:3.8

WORKDIR /app

ARG ENV=prod
ARG TIMEZONE='America/Sao_Paulo'

# Setting Timezone
ENV TIMEZONE=$TIMEZONE

RUN echo $TIMEZONE > /etc/timezone && \
    apt-get update && apt-get install -y tzdata netcat && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

# Install Requirements
COPY ./requirements/$ENV.txt .

RUN pip install --upgrade pip && \
    pip --no-cache-dir install -r ./$ENV.txt
