# METADATA
# title: "Verify that certificate validation isn't disabled with the PYTHONHTTPSVERIFY environmnet variable"
# description: "Ensures the security of containerized applications by verifying that certificate validation is not disabled using the PYTHONHTTPSVERIFY environment variable, preventing potential security vulnerabilities associated with unchecked SSL connections."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#env
# custom:
#   id: CB_DKR_016
#   severity: LOW
package lib.docker.CB_DKR_016

import future.keywords.in

resource := ["ARG", "ENV", "RUN"]

fail[args]{
    some args in input
    has_pip_args(args)
    args.instruction in resource
    some argument in args.args
    argument == "0"
}

fail[args]{
    value := "(.*\\s+)?(PYTHONHTTPSVERIFY(=|\\s+)((0)|('0')|(\"0\"))).*"
    some args in input
    args.instruction in resource
    some argument in args.args
    regex.match(value, argument)
}

has_pip_args(args){
    some argument in args.args
    argument == "PYTHONHTTPSVERIFY"
}

pass[args] {
    some args in input
    args.instruction in resource
    not fail[args]
}

passed[result] {
    some line in pass
	result := { "message": "Certificate validation isn't disabled with the PYTHONHTTPSVERIFY environmnet variable.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "Certificate validation should no be disabled with the PYTHONHTTPSVERIFY environmnet variable.",
                "snippet": line }
} 