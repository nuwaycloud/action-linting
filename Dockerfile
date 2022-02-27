FROM ghcr.io/cfy9/actionlint:1.6.4

RUN mkdir -p /apps/actionlint

COPY "entrypoint.sh" "entrypoint.sh"

WORKDIR /apps/actionlint

ENTRYPOINT ["./entrypoint.sh"]
