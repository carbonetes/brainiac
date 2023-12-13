# METADATA
# title: "Verify that certificate validation isn't disabled with wget"
# description: "Ensures the security of containerized applications by verifying that certificate validation is not disabled with wget, preventing potential vulnerabilities related to insecure communication."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#run
# custom:
#   id: CB_DKR_014
#   severity: LOW
package lib.docker.CB_DKR_014

import future.keywords.in

resource := "RUN"

fail[args]{
    some args in input
    args.instruction == resource
    some argument in args.args
    has_wget_args(args)
    argument == "--no-check-certificate"
}

has_wget_args(args){
    some argument in args.args
    argument == "wget"
}

pass[args] {
    some args in input
    args.instruction == resource
    has_wget_args(args)
    not fail[args]
}

passed[result] {
    some line in pass
	result := { "message": "Certificate validation isn't disabled with wget.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "Certificate validation should not be disabled with wget.",
                "snippet": line }
} 