# METADATA
# title: "Verify that sudo isn't used"
# description: "Avoiding the use of sudo in a Dockerfile enhances security by minimizing unnecessary privileges within the container, reducing the risk of potential vulnerabilities and unauthorized access."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#run
# custom:
#   id: CB_DKR_012
#   severity: LOW
package lib.docker.CB_DKR_012

import future.keywords.in

resource := "RUN"

fail[args]{
    some args in input
    args.instruction == resource
    some argument in args.args
    argument == "sudo"
}
 
pass[args] {
    some args in input
    args.instruction == resource
    count(fail) == 0
}

passed[result] {
    some line in pass
	result := { "message": "Sudo is not used.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "Sudo should not be used.",
                "snippet": line }
} 