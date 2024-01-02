package lib.docker.CB_DKR_008

test_last_user_not_root {
	result := passed with input as [
    {
        "line_range": {
            "startLine": 1,
            "endLine": 2
        },
        "instruction": "FROM",
        "args": [
            "base"
        ]
    },
    {
        "line_range": {
            "startLine": 3,
            "endLine": 4
        },
        "instruction": "USER",
        "args": [
            "root"
        ]
    },
    {
        "line_range": {
            "startLine": 5,
            "endLine": 6
        },
        "instruction": "USER",
        "args": [
            "nonroot"
        ]
    },
    {
        "line_range": {
            "startLine": 7,
            "endLine": 7
        },
        "instruction": "MAINTAINER",
        "args": [
            "bad"
        ]
    }
]
	count(result) == 1
}

test_last_user_root {
	result := failed with input as [
    {
        "line_range": {
            "startLine": 1,
            "endLine": 2
        },
        "instruction": "FROM",
        "args": [
            "base"
        ]
    },
    {
        "line_range": {
            "startLine": 3,
            "endLine": 4
        },
        "instruction": "USER",
        "args": [
            "root"
        ]
    },
    {
        "line_range": {
            "startLine": 7,
            "endLine": 7
        },
        "instruction": "MAINTAINER",
        "args": [
            "bad"
        ]
    }
]
	count(result) == 1
}
