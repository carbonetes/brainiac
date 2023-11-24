package lib.terraform.CB_TFGCP_038

test_google_storage_bucket_uniform_bucket_level_access_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_storage_bucket",
            "static-site"
        ],
        "Attributes": {
            "force_destroy": true,
            "location": "EU",
            "name": "image-store.com",
            "uniform_bucket_level_access": true
        },
        "Blocks": [
            {
                "Type": "website",
                "Labels": [],
                "Attributes": {
                    "main_page_suffix": "index.html",
                    "not_found_page": "404.html"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 8
                }
            },
            {
                "Type": "cors",
                "Labels": [],
                "Attributes": {
                    "max_age_seconds": "3600",
                    "method": [
                        "GET",
                        "HEAD",
                        "PUT",
                        "POST",
                        "DELETE"
                    ],
                    "origin": [
                        "http://image-store.com"
                    ],
                    "response_header": [
                        "*"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_storage_bucket_uniform_bucket_level_access_enabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_storage_bucket",
            "static-site"
        ],
        "Attributes": {
            "force_destroy": true,
            "location": "EU",
            "name": "image-store.com",
            "uniform_bucket_level_access": false
        },
        "Blocks": [
            {
                "Type": "website",
                "Labels": [],
                "Attributes": {
                    "main_page_suffix": "index.html",
                    "not_found_page": "404.html"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 8
                }
            },
            {
                "Type": "cors",
                "Labels": [],
                "Attributes": {
                    "max_age_seconds": "3600",
                    "method": [
                        "GET",
                        "HEAD",
                        "PUT",
                        "POST",
                        "DELETE"
                    ],
                    "origin": [
                        "http://image-store.com"
                    ],
                    "response_header": [
                        "*"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 1
        }
    }]
	count(result) == 1
}
