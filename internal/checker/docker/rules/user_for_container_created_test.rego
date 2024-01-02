package lib.docker.CB_DKR_003

test_user_has_been_created {
	result := passed with input as [
    {
        "line_range": {
            "startLine": 1,
            "endLine": 1
        },
        "instruction": "FROM",
        "args": [
            "base"
        ]
    },
    {
        "line_range": {
            "startLine": 3,
            "endLine": 3
        },
        "instruction": "LABEL",
        "args": [
            "foo=\"bar",
            "baz\""
        ]
    },
    {
        "line_range": {
            "startLine": 4,
            "endLine": 4
        },
        "instruction": "USER",
        "args": [
            "me"
        ]
    },
    {
        "line_range": {
            "startLine": 5,
            "endLine": 5
        },
        "instruction": "HEALTHCHECK",
        "args": [
            "CMD",
            "curl",
            "--fail",
            "http://localhost:3000",
            "||",
            "exit",
            "1"
        ]
    }
]
	count(result) == 1
}

test_user_not_created {
	result := failed with input as [
    {
        "line_range": {
            "startLine": 1,
            "endLine": 1
        },
        "instruction": "FROM",
        "args": [
            "base"
        ]
    },
    {
        "line_range": {
            "startLine": 3,
            "endLine": 3
        },
        "instruction": "LABEL",
        "args": [
            "foo=\"bar",
            "baz\""
        ]
    }
]
	count(result) == 1
}
