
<p align="center">
<img src="assets/IACOrig.svg" style="display: block; margin-left: auto; margin-right: auto; width: 50%;">
</p>


# Brainiac
[![Github All Releases](https://img.shields.io/github/downloads/carbonetes/brainiac/total.svg)]()
[![Go Report Card](https://goreportcard.com/badge/github.com/carbonetes/brainiac)](https://goreportcard.com/report/github.com/carbonetes/brainiac)
[![GitHub release](https://img.shields.io/github/release/carbonetes/brainiac.svg)](https://github.com/carbonetes/brainiac/releases/latest)
[![GitHub go.mod Go version](https://img.shields.io/github/go-mod/go-version/carbonetes/brainiac.svg)](https://github.com/carbonetes/brainiac)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/carbonetes/brainiac/blob/main/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/carbonetes/brainiac)](https://hub.docker.com/r/carbonetes/brainiac)

Brainiac uses static code analysis to analyze IAC code to detect security issues before deployment. This tool can scan for issues like security policy misconfigurations, insecure cloud-based services, and compliance issues. The Brainiac tool performs a comprehensive code scan and generates reports containing detailed insights into the identified issues.

## Features
- 🔍 | Scans IAC Code for misconfiguration.
- 📁 | Has hundreds of pre-defined rules.
- 📁 | Scans a target directory to fill in multiple results.
- ⛑ | Works with major platforms.
- 🗄 | Converts between formats such as JSON and Table brainiac own format.

### Supported Platform
- [Kubernetes](docs/Policy/KUBERNETES_POLICYRULES.md)

### Coming Soon
- Terraform(AWS, Azure, and etc.)
- Docker
- CloudFormation
- Serverles Framework
- AWS SAM
- ARM template files


# Installation 📥

## Installation Support OS 💽
- Mac
  - darwin_amd64.tar.gz
  - darwin_arm64.tar.gz
- Linux
  - deb
    - linux_amd64.deb
    - linux_arm64.deb
    - linux_ppc64le.deb
  - rpm
    - linux_amd64.rpm
    - linux_arm64.rpm
    - linux_ppc64le.rpm
  - tar.gz
    - linux_amd64.tar.gz
    - linux_arm64.tar.gz
    - linux_ppc64le.tar.gz
- Windows
  - windows_amd64.zip
## Recommended
```bash
curl -sSfL https://raw.githubusercontent.com/carbonetes/brainiac/main/install.sh | sh -s -- -d /usr/local/bin
```
you can specify a release version and destination directory for the installation:

```
curl -sSfL https://raw.githubusercontent.com/carbonetes/brainiac/main/install.sh | sh -s -- -d <DESTINATION_DIR> -v <RELEASE_VERSION>
```

## Getting Started 🚀 

### 
Scan a single file
```
brainiac -f <file>
```

Scan multiple file in a directory
```
brainiac -d .
```

## Using Docker
```
docker pull carbonetes/brainiac
```
Scan a directory
```
docker run -t -v {path_to_host_folder}:/tmpPath carbonetes/brainiac:latest -d /tmpPath
```

Scan a single file
```
docker run -t -v {path_to_host_folder}:/tmpPath carbonetes/brainiac:latest -f /path/{filename}.{extension}
```

The output format for Brainiac is configurable as well using the
`-o` (or `--output`) option:

The available `formats` are:
- `table`: A Tabular summary (default).
- `json`: Use this to get as much information out of Brainiac.

### Available Commands and their flags with description:
```
Brainiac [flag]
```
|                Root Flags                |                                                      Description                                                           |
| :--------------------------------------- | :------------------------------------------------------------------------------------------------------------------------- |
| `-f`, `--file`                    | File to scan                                                            |
| `-d`, `--dir`                     | Read directly from a path on disk (any directory) (e.g. 'brainiac -d path/to/dir)' (can not be used together with --file).                                              |
| `-o`, `--output`                  | Format to display results (table, json) (default "table")  
| `-v`, `--version`                 | Print Brainiac version 


## License

[Apache 2.0](https://choosealicense.com/licenses/apache-2.0/)