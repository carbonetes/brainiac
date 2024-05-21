package lib.terraform.CB_TFIBM_110

import rego.v1

test_pipeline_definition_source_type_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cd_tekton_pipeline_definition",
            "cd_tekton_pipeline_definition_instance"
        ],
        "Attributes": {
            "pipeline_id": "94619026-912b-4d92-8f51-6c74f0692d90"
        },
        "Blocks": [
            {
                "Type": "source",
                "Labels": [],
                "Attributes": {
                    "type": "^git$"
                },
                "Blocks": [
                    {
                        "Type": "properties",
                        "Labels": [],
                        "Attributes": {
                            "branch": "branch",
                            "path": "path",
                            "tag": "tag",
                            "url": "https://gb.conm"
                        },
                        "Blocks": [
                            {
                                "Type": "tool",
                                "Labels": [],
                                "Attributes": {
                                    "id": "id"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 12,
                                    "startLine": 10
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 13,
                            "startLine": 5
                        }
                    }
                ],
                "line_range": {
                    "endLine": 14,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_pipeline_definition_source_type_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cd_tekton_pipeline_definition",
            "cd_tekton_pipeline_definition_instance"
        ],
        "Attributes": {
            "pipeline_id": "94619026-912b-4d92-8f51-6c74f0692d90"
        },
        "Blocks": [
            {
                "Type": "source",
                "Labels": [],
                "Attributes": {
                    "type": "git"
                },
                "Blocks": [
                    {
                        "Type": "properties",
                        "Labels": [],
                        "Attributes": {
                            "branch": "branch",
                            "path": "path",
                            "tag": "tag",
                            "url": "this is my website"
                        },
                        "Blocks": [
                            {
                                "Type": "tool",
                                "Labels": [],
                                "Attributes": {
                                    "id": "id"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 12,
                                    "startLine": 10
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 13,
                            "startLine": 5
                        }
                    }
                ],
                "line_range": {
                    "endLine": 14,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 1
        }
    }]
	count(result) == 1
}
