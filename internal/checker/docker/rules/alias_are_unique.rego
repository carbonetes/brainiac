# METADATA
# title: "Verify From Alias are unique for multistage builds"
# description: "Ensuring unique FROM aliases in multistage Docker builds helps prevent potential conflicts and ambiguities, leading to more reliable and maintainable container images."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#from
# custom:
#   id: CB_DKR_011
#   severity: LOW
package lib.docker.CB_DKR_011

import future.keywords.in

resource := "FROM"

all_alias[alias]{
    some args in input
    args.instruction == resource
    alias := args.args[2]
}

from_instruction[args]{
	some args in input
    args.instruction == resource
    count(args.args) == 3
}

fail[args]{
    count(all_alias) != 0
    count(from_instruction) != count(all_alias)
    some args in from_instruction
}
 
pass[args] {
    some args in input
    args.instruction == resource
    count(fail) == 0
}

passed[result] {
    some line in pass
	result := { "message": "Alias are unique for multistage builds.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "Alias should be unique for multistage builds.",
                "snippet": line }
} 