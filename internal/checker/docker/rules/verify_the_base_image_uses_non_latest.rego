# METADATA
# title: "Verify the base image uses a non latest version tag"
# description: "By specifying a particular version tag for the base image, you prevent unintentional updates to the latest version, reducing the risk of unexpected changes or potential issues due to differences in the base image."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#from
# custom:
#   id: CB_DKR_007
#   severity: LOW
package lib.docker.CB_DKR_007

import future.keywords.in

resource := "FROM"

check_image(args){
   image := args.args[0]
   image != "scratch"
   not contains(image, ":")
}

check_image(args){
   image := args.args[0]
   image != "scratch"
   contains(image, ":latest")
}

fail[args]{
    some args in input
    args.instruction == resource
    check_image(args)
}
 
pass[args] {
    some args in input
    args.instruction == resource
    not fail[args]
}

passed[result] {
    some line in pass
	result := { "message": "Base image uses a non latest version tag.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "Base image uses a non latest version tag.",
                "snippet": line }
} 