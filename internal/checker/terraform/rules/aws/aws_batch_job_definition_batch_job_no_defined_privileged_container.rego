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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_batch_job_definition"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    containerPropStr := resource.Attributes.container_properties
    containerParsed := json.unmarshal(containerPropStr)
    containerParsed.privileged == true
}

passed[result] {
	block := pass[_]
	result := { "message": "Privileged container is not defined by a batch job.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Privileged container should not be defined by a batch job.",
                "snippet": block }
} 