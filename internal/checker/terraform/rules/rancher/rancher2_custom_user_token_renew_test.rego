package lib.terraform.CB_TFRAN_122

test_rancher2_custom_user_token_renew_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_custom_user_token",
            "foo"
        ],
        "Attributes": {
            "depends_on": "rancher2_global_role_binding.foo-login",
            "description": "foo token",
            "password": "rancher2_user.foo.password",
            "renew": true,
            "ttl": "0",
            "username": "rancher2_user.foo.username"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_custom_user_token_renew_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_custom_user_token",
            "foo"
        ],
        "Attributes": {
            "depends_on": "rancher2_global_role_binding.foo-login",
            "description": "foo token",
            "password": "rancher2_user.foo.password",
            "renew": false,
            "ttl": "0",
            "username": "rancher2_user.foo.username"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
    count(result) == 1
}