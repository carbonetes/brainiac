package lib.terraform.CB_TFIBM_043

import rego.v1

test_virtual_fuest_member_contains_ssh_key_pass if {
	result := passed with input as [ {
        "Type": "resource",
        "Labels": [
            "ibm_compute_autoscale_group",
            "test_scale_group"
        ],
        "Attributes": {
            "virtual_guest_member_template": {
                "cores": "1",
                "datacenter": "sng01",
                "disks": [
                    "25"
                ],
                "domain": "example.com",
                "hostname": "test_virtual_guest_name",
                "hourly_billing": true,
                "local_disk": false,
                "memory": "1024",
                "network_speed": "100",
                "os_reference_code": "DEBIAN_8_64",
                "post_install_script_uri": "",
                "ssh_key_ids": [
                    "383111"
                ],
                "user_metadata": "#!/bin/bash ..."
            },
            "virtual_server_id": "267513"
        }
    }]
	count(result) == 1
}

test_virtual_fuest_member_contains_ssh_key_fail if {
	result := failed with input as [{
             "Type": "resource",
        "Labels": [
            "ibm_compute_autoscale_group",
            "test_scale_group"
        ],
        "Attributes": {
            "virtual_guest_member_template": {
                "cores": "1",
                "datacenter": "sng01",
                "disks": [
                    "25"
                ],
                "domain": "example.com",
                "hostname": "test_virtual_guest_name",
                "hourly_billing": true,
                "local_disk": false,
                "memory": "1024",
                "network_speed": "100",
                "os_reference_code": "DEBIAN_8_64",
                "post_install_script_uri": "",
                "user_metadata": "#!/bin/bash ..."
            },
            "virtual_server_id": "267513"
        }
    }]
	count(result) == 1
}
