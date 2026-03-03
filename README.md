# bash-read-env-file
Read an env file and output key/value pairs, optionally into a template.

## Basic Usage

Use environment variable `ENV_FILE_PATH` to specify the path to the file to be read and then execute the script.

The following example works when executed from the root of this project:

```bash
ENV_FILE_PATH=tests/fixtures/multiple.env \
./src/read-env-file.sh
```

```
KEY1=string
KEY2=12
KEY3=2.34
```

## Output Templates

By default, the env file is echo'd out as-is. You probably won't get much use from this. 

The keys and values defined in the env file can be output into a template. This I find useful.

Use environment variable `OUTPUT_TEMPLATE`, along with placeholders `{{ key }}` and `{{ value }}`, to define how each
key/value pair is to be output.

```bash
ENV_FILE_PATH=tests/fixtures/multiple.env \
OUTPUT_TEMPLATE="'{{ key }}' has the value '{{ value }}'" \
./src/read-env-file.sh
```

```
'KEY1' has the value 'string'
'KEY2' has the value '12'
'KEY3' has the value '2.34'
```

## Output Path

Use environment variable `OUTPUT_PATH` to specify the path to the file to be written.

## Reading in Github Actions Workflow

A tiny bit of syntactic sugar to read an env file in a Github actions workflow and render in 
[Github Actions output parameter-setting format][1]:

```bash
ENV_FILE_PATH=tests/fixtures/multiple.env \
./src/read-env-file-ga.sh
```

```
::set-output name=KEY1::string
::set-output name=KEY2::12
::set-output name=KEY3::2.34
```

A [working example workflow][2] shows how you might use this in your own workflow.

[1]: https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-output-parameter
[2]: https://github.com/smartassert/bash-read-env-file/blob/main/.github/workflows/example.yml
