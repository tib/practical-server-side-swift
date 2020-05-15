# Build image
FROM swift:5.2.3-bionic as build

RUN apt-get update -y \
    && apt-get install -y libsqlite3-dev

WORKDIR /build

COPY . .

RUN for f in Sources/App/Modules/*; do \
    m=$(basename $f); \
    cp -r "${f}/Views/" "Resources/Views/${m}" 2>/dev/null; \
    done; \
    exit 0;

RUN swift build \
    --enable-test-discovery \
    -c release \
    -Xswiftc -g

# Run image
FROM swift:5.2.3-bionic-slim

RUN useradd --user-group --create-home --home-dir /app vapor

WORKDIR /app

COPY --from=build --chown=vapor:vapor /build/.build/release /app
COPY --from=build --chown=vapor:vapor /build/Public /app/Public
COPY --from=build --chown=vapor:vapor /build/Resources /app/Resources

ARG AWS_RDS_HOST
ARG AWS_RDS_USER
ARG AWS_RDS_PASS
ARG AWS_RDS_DB
ARG FS_NAME
ARG FS_REGION
ARG AWS_KEY
ARG AWS_SECRET

RUN echo "DB_HOST=${AWS_RDS_HOST}" > .env.production
RUN echo "DB_USER=${AWS_RDS_USER}" >> .env.production
RUN echo "DB_PASS=${AWS_RDS_PASS}" >> .env.production
RUN echo "DB_NAME=${AWS_RDS_DB}" >> .env.production
RUN echo "FS_NAME=${FS_NAME}" >> .env.production
RUN echo "FS_REGION=${FS_REGION}" >> .env.production
RUN echo "AWS_KEY=${AWS_KEY}" >> .env.production
RUN echo "AWS_SECRET=${AWS_SECRET}" >> .env.production

USER vapor
ENTRYPOINT ["./Run"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]
