# METADATA
# title: "Verify that LABEL maintainer is used instead of MAINTAINER"
# description: "This ensures alignment with modern Dockerfile conventions and helps in creating more maintainable and readable Dockerfiles."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#label
# custom:
#   id: CB_DKR_006
#   severity: LOW
package lib.docker.CB_DKR_006

import future.keywords.in

resource := "MAINTAINER"

fail[args]{
    some args in input
    args.instruction == resource
}
 
has_label_value_maintener[args] {
    count(has_label_args) == 1
    some args in has_label_args
}

has_label_args[args]{
	some args in input
    args.instruction == "LABEL"
    some argument in args.args
    contains(argument, "maintainer")
}

passed[result] {
    count(fail) == 0
    some args in has_label_value_maintener
	result := { "message": "LABEL maintainer is used instead of MAINTAINER",
                "snippet": args }
}

failed[result] {
    some line in fail
	result := { "message": "Used LABEL maintainer instead of MAINTAINER.",
                "snippet": line }
} 