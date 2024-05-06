# METADATA
# title: "There is no privileged container defined by a batch job"
# description: "You can make sure that your AWS Batch job has the rights necessary to access system devices like GPUs or hardware accelerators, change system-level configuration files, and more by designating it as a privileged container. However, giving a job too much freedom may increase the dangers to security because the work will have more authority over private system resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PixarV/ritt/latest/docs/resources/batch_job_definition
# custom:
#   id: CB_TFAWS_235
#   severity: LOW
package lib.terraform.CB_TFAWS_235
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_batch_job_definition"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains block if {
	some block in input
	isvalid(block)
   	not fail[block]
}

fail contains resource if {
    some resource in input
    isvalid(resource)
    container_prop_str := resource.Attributes.container_properties
    container_parsed := json.unmarshal(container_prop_str)
    container_parsed.privileged == true
}

passed contains result if {
    some block in pass
	result := { "message": "Privileged container is not defined by a batch job.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Privileged container should not be defined by a batch job.",
                "snippet": block }
} 