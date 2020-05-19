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

# Install elm-analyse and elm-linter (not globally)
RUN npm install -g elm-analyse && \
    npm install elm-format
ENV PATH=$PATH:/code/node_modules/elm-linter/bin:/code/node_modules/elm-format/bin
EXPOSE 8000
ENTRYPOINT ["/code/docker/entrypoint.sh"]
