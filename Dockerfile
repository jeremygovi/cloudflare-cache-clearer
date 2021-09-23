FROM curlimages/curl:7.79.1

ADD clear-cache.sh /usr/local/bin/clear-cache

CMD clear-cache
