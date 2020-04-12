FROM node:10

WORKDIR /code

RUN apt-get update && \
    apt-get install -y \
       --no-install-recommends \ 
           curl \
           gzip && \
           rm -rf /var/lib/apt/lists/* 

# Install and cache dependencies
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz && \
    gunzip elm.gz && \
    chmod +x elm && \
    mv elm /usr/local/bin/

# Add remainder of files
COPY . .

EXPOSE 8000
ENTRYPOINT ["/code/docker/entrypoint.sh"]
