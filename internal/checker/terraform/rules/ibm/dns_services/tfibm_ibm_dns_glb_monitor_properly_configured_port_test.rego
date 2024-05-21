package lib.terraform.CB_TFIBM_115

import rego.v1 

test_tfibm_ibm_dns_glb_monitor_properly_configured_port_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_dns_glb_monitor",
            "test-pdns-monitor"
        ],
        "Attributes": {
            "depends_on": "ibm_dns_zone.test-pdns-zone",
            "description": "test monitor description",
            "expected_body": "alive",
            "expected_codes": "200",
            "instance_id": "ibm_resource_instance.test-pdns-instance.guid",
            "interval": "63",
            "method": "GET",
            "name": "test-pdns-glb-monitor",
            "path": "/health",
            "retries": "3",
            "timeout": "8",
            "type": "HTTP"
        },
        "Blocks": [
            {
                "Type": "headers",
                "Labels": [],
                "Attributes": {
                    "name": "headerName",
                    "value": [
                        "example",
                        "abc"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 15
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_ibm_dns_glb_monitor_properly_configured_port_failed if {
    result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_dns_glb_monitor",
            "test-pdns-monitor"
        ],
        "Attributes": {
            "depends_on": "ibm_dns_zone.test-pdns-zone",
            "description": "test monitor description",
            "expected_body": "alive",
            "expected_codes": "200",
            "instance_id": "ibm_resource_instance.test-pdns-instance.guid",
            "interval": "63",
            "method": "GET",
            "name": "test-pdns-glb-monitor",
            "path": "/health",
            "port": "8080",
            "retries": "3",
            "timeout": "8",
            "type": "HTTP"
        },
        "Blocks": [
            {
                "Type": "headers",
                "Labels": [],
                "Attributes": {
                    "name": "headerName",
                    "value": [
                        "example",
                        "abc"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 15
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 1
        }
    }
]
    count(result) == 1
}