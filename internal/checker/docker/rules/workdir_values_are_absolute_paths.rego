# METADATA
# title: "Verify that WORKDIR values are absolute paths"
# description: "Ensuring that WORKDIR values are absolute paths in Dockerfiles enhances portability, avoids ambiguity, and helps maintain consistency across different environments, contributing to more reliable and reproducible container builds."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#workdir
# custom:
#   id: CB_DKR_010
#   severity: LOW
package lib.docker.CB_DKR_010

import future.keywords.in

resource := "WORKDIR"

fail[args]{
    some args in input
    args.instruction == resource
    some argument in args.args
    not regex.match(`^(\$|/)`, argument)
}
 
pass[args] {
    some args in input
    args.instruction == resource
    count(fail) == 0
}

passed[result] {
    some line in pass
	result := { "message": "WORKDIR values are absolute paths.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "WORKDIR should be absolute paths.",
                "snippet": line }
} 