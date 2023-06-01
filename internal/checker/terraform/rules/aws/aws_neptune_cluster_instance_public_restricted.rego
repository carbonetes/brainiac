# METADATA
# title: "See to it that the Neptune Cluster instance is not accessible to the general public"
# description: "With Neptune, you can also take database snapshots that you can later utilize to recover a database from. An owner of the recipient account can use the snapshot you share with them to restore a database that contains your data. You can share a snapshot with another Amazon Web Services account. A database holding your data can be restored by anyone if you decide to make your snapshots public."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster_instance
# custom:
#   id: CB_TFAWS_071
#   severity: LOW
package lib.terraform.CB_TFAWS_071

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_neptune_cluster_instance"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 


pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.publicly_accessible == false
   
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Neptune cluster instance cannot be accessed publicly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Neptune cluster instance should not be available for public access.",
                "snippet": block}
}
