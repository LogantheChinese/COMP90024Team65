# Handy command to start this dockerfile in one line:
# docker run --rm -p 5432:5432 -it $(docker build -q -f database.Dockerfile .)

FROM postgres:14-alpine

ENV POSTGRES_PASSWORD='admin'
ENV POSTGRES_USER='admin'
ENV POSTGRES_DB='dda-lcl'

EXPOSE 5432 5432
