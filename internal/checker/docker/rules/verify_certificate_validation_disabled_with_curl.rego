# METADATA
# title: "Verify that certificate validation isn't disabled with curl"
# description: "Ensures the security of containerized applications by verifying that certificate validation is not disabled with curl, preventing potential vulnerabilities related to insecure communication."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#run
# custom:
#   id: CB_DKR_013
#   severity: LOW
package lib.docker.CB_DKR_013

import future.keywords.in

resource := "RUN"

fail[args]{
    some args in input
    args.instruction == resource
    some argument in args.args
    argument == "--insecure"
}

pass[args] {
    some args in input
    args.instruction == resource
    some argument in args.args
    argument == "curl"
    not fail[args]
}

passed[result] {
    some line in pass
	result := { "message": "Certificate validation isn't disabled with curl.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "Certificate validation should not be disabled with curl.",
                "snippet": line }
} 