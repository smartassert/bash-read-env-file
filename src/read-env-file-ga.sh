#!/usr/bin/env bash

if [ -z "$OUTPUT_PATH" ]; then
  $OUTPUT_PATH="$GITHUB_ENV"
fi

CURRENT_DIRECTORY=$(dirname "$0")

#echo "service_version=$RELEASE_TAG_NAME" >> "$GITHUB_ENV"
# OUTPUT_PATH="${TEST_TEMP_DIR}/output" \

#OUTPUT_TEMPLATE="::set-output name={{ key }}::{{ value }}" \
#OUTPUT_TEMPLATE="service_version=$RELEASE_TAG_NAME" \
"$CURRENT_DIRECTORY"/read-env-file.sh
