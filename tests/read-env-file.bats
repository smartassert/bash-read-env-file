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
  bash "${BATS_TEST_DIRNAME}/../src/read-env-file.sh"
}

@test "read-env-file: empty file" {
  ENV_FILE_PATH="${fixtures_relative_path}/empty.env" \
  run main

  assert_success
  assert_output ""
}

@test "read-env-file: single-item file" {
  ENV_FILE_PATH="${fixtures_relative_path}/single.env" \
  run main

  assert_success
  assert_output "KEY1=string"
}

@test "read-env-file: single-item file, output to file" {
  assert_file_empty "${TEST_TEMP_DIR}/output"

  OUTPUT_PATH="${TEST_TEMP_DIR}/output" \
  ENV_FILE_PATH="${fixtures_relative_path}/single.env" \
  run main

  assert_success
  assert_file_not_empty "${TEST_TEMP_DIR}/output"
  assert_file_contains "${TEST_TEMP_DIR}/output" "KEY1=string"
}

@test "read-env-file: multi-item file" {
  ENV_FILE_PATH="${fixtures_relative_path}/multiple.env" \
  run main

  assert_success
  assert_output "KEY1=string
KEY2=12
KEY3=2.34"
}

@test "read-env-file: multi-item file with blank lines between items" {
  ENV_FILE_PATH="${fixtures_relative_path}/multiple-with-blank-lines.env" \
  run main

  assert_success
  assert_output "KEY1=string
KEY2=12
KEY3=2.34"
}
