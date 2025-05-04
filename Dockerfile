FROM python:3.11.9-slim AS builder

WORKDIR /root

RUN apt update \
    && apt install git -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY . .
RUN pip install --upgrade pip \
    && pip install --no-cache-dir .


FROM python:3.11.9-slim

WORKDIR /root

COPY --from=builder /usr/local /usr/local

# TODO get preprocessor joblib from github
COPY model/preprocessor.joblib /root/model/preprocessor.joblib

ENTRYPOINT ["python"]
CMD ["-m", "app.main"]