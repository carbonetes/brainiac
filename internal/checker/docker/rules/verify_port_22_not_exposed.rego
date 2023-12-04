# METADATA
# title: "Verify port 22 is not exposed"
# description: "This security measure ensures that port 22, commonly associated with SSH access, is not exposed in a Dockerfile, reducing the risk of unauthorized access and potential security vulnerabilities."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#expose
# custom:
#   id: CB_DKR_001
#   severity: LOW
package lib.docker.CB_DKR_001

import future.keywords.in
import future.keywords.if

resource := "EXPOSE"

fail[args]{
    some args in input
    args.instruction == resource
    some arguments in args.args
    invalid_ports := ["22", "22/tcp"]
    arguments in invalid_ports
}

has_expose_value := args if {
    count(pass_expose_args) == 1
    some args in pass_expose_args
} else := args {
    args := {}
}

pass_expose_args[args]{
	some args in input
    args.instruction == resource
    not fail[args]
}
 
passed[result] {
	count(fail) == 0
	result := { "message": "Port 22 is not exposed.",
                "snippet": has_expose_value }
}

failed[result] {
    some line in fail
	result := { "message": "Port 22 should not be exposed.",
                "snippet": line }
} 