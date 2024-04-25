package lib.terraform.CB_TFIBM_046

import rego.v1

test_domain_not_exposed_information_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_compute_dedicated_host",
            "dedicatedhost"
        ],
        "Attributes": {
            "cpu_count": "32",
            "datacenter": "us-south",
            "disk_capacity": "1 TB",
            "domain": "",
            "flavor": "32_CORES_X_128_RAM_X_1_TB",
            "hostname": "host-01",
            "hourly_billing": false,
            "id": "dh-1234567890",
            "memory_capacity": "128 GB",
            "router_hostname": "bcr01a.dal09",
            "tags": [
                "production",
                "web-server"
            ],
            "wait_time_minutes": "60"
        }
    }]
	count(result) == 1
}

test_domain_not_exposed_information_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_compute_dedicated_host",
            "dedicatedhost"
        ],
        "Attributes": {
            "cpu_count": "32",
            "datacenter": "us-south",
            "disk_capacity": "1 TB",
            "domain": "123",
            "flavor": "32_CORES_X_128_RAM_X_1_TB",
            "hostname": "host-01",
            "hourly_billing": false,
            "id": "dh-1234567890",
            "memory_capacity": "128 GB",
            "router_hostname": "bcr01a.dal09",
            "tags": [
                "production",
                "web-server"
            ],
            "wait_time_minutes": "60"
        }
    }]
	count(result) == 1
}
