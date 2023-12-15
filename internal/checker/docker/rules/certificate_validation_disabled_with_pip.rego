# METADATA
# title: "Verify that certificate validation isn't disabled with the pip '--trusted-host' option"
# description: "Enhances container security by verifying that certificate validation is not disabled using the pip '--trusted-host' option, mitigating potential risks associated with insecure connections during package installations."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#run
# custom:
#   id: CB_DKR_015
#   severity: LOW
package lib.docker.CB_DKR_015

import future.keywords.in

resource := "RUN"

fail[args]{
    some args in input
    has_pip_args(args)
    args.instruction == resource
    some argument in args.args
    argument == "--trusted-host"
}

has_pip_args(args){
    some argument in args.args
    pip_argument := ["pip3", "pip"]
    argument in pip_argument
}

pass[args] {
    some args in input
    args.instruction == resource
    has_pip_args(args)
    not fail[args]
}

passed[result] {
    some line in pass
	result := { "message": "Certificate validation isn't disabled with the pip '--trusted-host' option.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "Certificate validation should be disabled with the pip '--trusted-host' option.",
                "snippet": line }
} 