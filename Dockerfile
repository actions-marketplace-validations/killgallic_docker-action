FROM docker:stable

LABEL "name"="Docker Action"
LABEL "maintainer"="its"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Fluidity Docker Action'"
LABEL "com.github.actions.description"="Builds a docker container using github"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="purple"

RUN apk update \
  && apk upgrade \
  && apk add --no-cache git bash

COPY entrypoint.sh /entrypoint.sh
ENV PAT_STRING $PAT_STRING
ENTRYPOINT ["/entrypoint.sh"]
