#!/usr/bin/env bats

export fixtures_relative_path="${BATS_TEST_DIRNAME}/fixtures"

setup() {
  load 'node_modules/bats-support/load'
  load 'node_modules/bats-assert/load'
  load 'node_modules/bats-file/load'
    TEST_TEMP_DIR="$(temp_make)"
}

teardown() {
  temp_del "$TEST_TEMP_DIR"
}

main() {
  bash "${BATS_TEST_DIRNAME}/../src/read-env-file-ga.sh"
}

@test "read-env-file-ga: github action 'set output' output template is used" {
  ENV_FILE_PATH="${fixtures_relative_path}/multiple.env" \
  run main

  assert_success
  assert_output "::set-output name=KEY1::string
::set-output name=KEY2::12
::set-output name=KEY3::2.34"
}

@test "read-env-file-ga: github action 'set output' output template is used, output to file" {
  assert_file_empty "${TEST_TEMP_DIR}/output"

  OUTPUT_PATH="${TEST_TEMP_DIR}/output" \
  ENV_FILE_PATH="${fixtures_relative_path}/multiple.env" \
  run main

  assert_success
  assert_file_not_empty "${TEST_TEMP_DIR}/output"
  assert_file_contains "${TEST_TEMP_DIR}/output" "::set-output name=KEY1::string"
  assert_file_contains "${TEST_TEMP_DIR}/output" "::set-output name=KEY2::12"
  assert_file_contains "${TEST_TEMP_DIR}/output" "::set-output name=KEY3::2.34"
}
