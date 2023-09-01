# METADATA
# title: "Verify ElasticSearch/OpenSearch has dedicated master node enabled"
# description: "By enabling dedicated master nodes, you ensure that cluster management tasks are segregated from data and query processing, leading to improved cluster stability and responsiveness."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain#cluster_config
# custom:
#   id: CB_TFAWS_359
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_359


supportedResources := ["aws_elasticsearch_domain", "aws_opensearch_domain"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "cluster_config"
    block.Attributes.dedicated_master_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "ElasticSearch/OpenSearch has dedicated master node enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": " ElasticSearch/OpenSearch should have dedicated master node enabled.",
                "snippet": block }
}
