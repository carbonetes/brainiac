package lib.terraform.CB_TFIBM_074

import rego.v1

test_lbaas_frontend_protocol_is_https_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lbaas",
            "lbaas"
        ],
        "Attributes": {
            "datacenter": "datacenter1",
            "description": "delete this",
            "name": "terraformLB",
            "ssl_ciphers": [
                "cipher1",
                "cipher2"
            ],
            "status": "online",
            "subnets": [
                "1511875"
            ],
            "type": "PUBLIC",
            "use_system_public_ip_pool": true,
            "vip": "192.168.1.100",
            "wait_time_minutes": "90"
        },
        "Blocks": [
            {
                "Type": "protocols",
                "Labels": [],
                "Attributes": {
                    "backend_port": "80",
                    "backend_protocol": "HTTPS",
                    "frontend_port": "443",
                    "frontend_protocol": "HTTPS",
                    "load_balancing_method": "round_robin",
                    "max_conn": "1000",
                    "session_stickiness": "SOURCE_IP",
                    "tls_certificate_id": 234234324
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 6
                }
            },
            {
                "Type": "protocols",
                "Labels": [],
                "Attributes": {
                    "backend_port": "80",
                    "backend_protocol": "HTTP",
                    "frontend_port": "80",
                    "frontend_protocol": "HTTP",
                    "load_balancing_method": "round_robin",
                    "max_conn": "1000",
                    "session_stickiness": "SOURCE_IP"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 17
                }
            },
            {
                "Type": "health_monitors",
                "Labels": [],
                "Attributes": {
                    "interval": "10s",
                    "max_retries": "3",
                    "monitor_id": "1234",
                    "port": "80",
                    "protocol": "HTTP",
                    "timeout": "5s",
                    "url_path": "/health_check"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 40,
                    "startLine": 32
                }
            }
        ],
        "line_range": {
            "endLine": 44,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_lbaas_frontend_protocol_is_https_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lbaas",
            "lbaas"
        ],
        "Attributes": {
            "datacenter": "datacenter1",
            "description": "delete this",
            "name": "terraformLB",
            "ssl_ciphers": [
                "cipher1",
                "cipher2"
            ],
            "status": "online",
            "subnets": [
                "1511875"
            ],
            "type": "PUBLIC",
            "use_system_public_ip_pool": true,
            "vip": "192.168.1.100",
            "wait_time_minutes": "90"
        },
        "Blocks": [
            {
                "Type": "protocols",
                "Labels": [],
                "Attributes": {
                    "backend_port": "80",
                    "backend_protocol": "HTTPS",
                    "frontend_port": "443",
                    "frontend_protocol": "HTTP",
                    "load_balancing_method": "round_robin",
                    "max_conn": "1000",
                    "session_stickiness": "SOURCE_IP",
                    "tls_certificate_id": 234234324
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 6
                }
            },
            {
                "Type": "protocols",
                "Labels": [],
                "Attributes": {
                    "backend_port": "80",
                    "backend_protocol": "HTTP",
                    "frontend_port": "80",
                    "frontend_protocol": "HTTP",
                    "load_balancing_method": "round_robin",
                    "max_conn": "1000",
                    "session_stickiness": "SOURCE_IP"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 17
                }
            },
            {
                "Type": "health_monitors",
                "Labels": [],
                "Attributes": {
                    "interval": "10s",
                    "max_retries": "3",
                    "monitor_id": "1234",
                    "port": "80",
                    "protocol": "HTTP",
                    "timeout": "5s",
                    "url_path": "/health_check"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 40,
                    "startLine": 32
                }
            }
        ],
        "line_range": {
            "endLine": 44,
            "startLine": 1
        }
    }]
	count(result) == 1
}
