# METADATA
# title: "Verify that COPY is used instead of ADD in Dockerfiles"
# description: "This enhances the Dockerfile's readability and reduces potential issues related to the automatic extraction features of the ADD instruction."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#copy
# custom:
#   id: CB_DKR_004
#   severity: LOW
package lib.docker.CB_DKR_004

import future.keywords.in

resource := "ADD"

fail[args]{
    some args in input
    args.instruction == resource
}
 
has_copy_value[args] {
    count(has_copy_args) == 1
    some args in has_copy_args
}

has_copy_args[args]{
	some args in input
    args.instruction == "COPY"
}

passed[result] {
    count(fail) == 0
    some args in has_copy_value
	result := { "message": "COPY is used in Dockerfile instead of ADD.",
                "snippet": args }
}

failed[result] {
    some line in fail
	result := { "message": "COPY should be used instead of ADD in Dockerfile.",
                "snippet": line }
} 