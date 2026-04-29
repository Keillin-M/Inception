FROM debian:bookworm

# - nginx:        the web server
# - openssl:      generate the self-signed TLS cert at startup
# - gettext-base: provides `envsubst`, used to inject ${DOMAIN_NAME} from
#                 the .env file into nginx.conf at container start.
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    openssl \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Templated config — the entrypoint substitutes ${DOMAIN_NAME} into it.
COPY conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/script.sh"]
