# METADATA
# title: "Verify the last USER is not root"
# description: "Running processes as a non-root user enhances container security, limiting the privileges available to potential attackers and mitigating the impact of security vulnerabilities."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#user
# custom:
#   id: CB_DKR_008
#   severity: LOW
package lib.docker.CB_DKR_008

import future.keywords.in

resource := "USER"

fail[args]{
	args := input[last_user_index]
    some user in args.args
    user == "root"
}

last_user_index := last_num {
    indices = [i | input[i].instruction == "USER"]
    last_num := max(indices)
}

pass[args] {
    args := input[last_user_index]
    args.instruction == resource
    count(fail) == 0
}

passed[result] {
    some line in pass
	result := { "message": "Last USER is not root.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "Last USER should be not root.",
                "snippet": line }
} 