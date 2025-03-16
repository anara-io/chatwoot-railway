# FROM ghcr.io/railwayapp-templates/chatwoot:Community
# https://hub.docker.com/r/chatwoot/chatwoot/tags
FROM anarallc/chatwoot:latest

# Add environment variables for CORS configuration
ARG CW_CORS_ALLOWED_ORIGINS='*'
ARG CW_ENABLE_API_ACCESS=true

RUN apk add --no-cache multirun postgresql-client

COPY --chmod=755 start.sh ./

ENTRYPOINT ["/bin/sh"]

CMD ["start.sh"]