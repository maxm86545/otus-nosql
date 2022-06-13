#!/bin/bash

set -e

function elastic() {
  REQUEST_METHOD=${1:-GET}
  REQUEST_PATH="/${2}"
  REQUEST_BODY=${3}

  echo "=== ${REQUEST_METHOD} ${REQUEST_PATH}"

  if [ "$REQUEST_BODY" != '' ]; then
    echo "$REQUEST_BODY"
  fi

  echo "Response:"

  curl --user "$ELASTIC_USER":"$ELASTIC_PASSWORD" \
    "localhost:9200${REQUEST_PATH}" \
    -X "${REQUEST_METHOD}" \
    -H 'Content-Type: application/json' \
    -d "${REQUEST_BODY}"

  echo
  echo "======================================="
}

elastic POST test/_search?pretty \
'{
  "query": {
    "match": {
      "text": {
        "query": "мама ела сосиски",
        "fuzziness": "auto"
      }
    }
  }
}'