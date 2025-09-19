# Adapter
FROM inspectorgadget12/lambda-runtime-adapter:latest AS aws-lwa

# Final image
FROM docker/model-runner:latest AS model-runner

# Register the Lambda Web Adapter
COPY --from=aws-lwa /lambda-runtime-adapter /opt/extensions/lambda-adapter

# LWA -> app port
ENV AWS_LWA_PORT=12434
ENV AWS_LWA_READINESS_CHECK_PROTOCOL=tcp

# Writable model store (runner writes layout.json/models.json here)
ENV MODELS_PATH=/models

# Ensure the models path exists
RUN mkdir -p ${MODELS_PATH}

# Copy your local models into the image (next to the Dockerfile: ./models/*.gguf)
COPY models/ ${MODELS_PATH}/

# Put the socket and any temp files under /tmp
WORKDIR /tmp
ENV TMPDIR=/tmp
ENV XDG_RUNTIME_DIR=/tmp

EXPOSE 12434

CMD [ "sh", "-lc", "exec model-runner serve" ]