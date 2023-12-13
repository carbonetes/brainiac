package lib.docker.CB_DKR_013

test_certificate_validation_disabled_with_curl {
	result := passed with input as [
    {
        "line_range": {
            "startLine": 1,
            "endLine": 1
        },
        "instruction": "FROM",
        "args": [
            "debian:jesse1",
            "as",
            "build"
        ]
    },
    {
        "line_range": {
            "startLine": 2,
            "endLine": 3
        },
        "instruction": "RUN",
        "args": [
            "stuff"
        ]
    },
    {
        "line_range": {
            "startLine": 4,
            "endLine": 4
        },
        "instruction": "FROM",
        "args": [
            "debian:jesse1",
            "as",
            "another-alias"
        ]
    },
    {
        "line_range": {
            "startLine": 5,
            "endLine": 6
        },
        "instruction": "RUN",
        "args": [
            "more_stuff"
        ]
    },
    {
        "line_range": {
            "startLine": 7,
            "endLine": 9
        },
        "instruction": "RUN",
        "args": [
            "apk",
            "add",
            "--no-cache",
            "curl",
            "\u0026\u0026",
            "\\",
            "curl",
            "-o",
            "/tmp/example.txt",
            "https://example.com",
            "\u0026\u0026",
            "\\",
            "cat",
            "/tmp/example.txt"
        ]
    }
]
	count(result) == 1
}

test_certificate_validation_not_disabled_with_curl {
	result := failed with input as [
    {
        "line_range": {
            "startLine": 1,
            "endLine": 1
        },
        "instruction": "FROM",
        "args": [
            "debian:jesse1",
            "as",
            "build"
        ]
    },
    {
        "line_range": {
            "startLine": 2,
            "endLine": 3
        },
        "instruction": "RUN",
        "args": [
            "stuff"
        ]
    },
    {
        "line_range": {
            "startLine": 4,
            "endLine": 4
        },
        "instruction": "FROM",
        "args": [
            "debian:jesse1",
            "as",
            "another-alias"
        ]
    },
    {
        "line_range": {
            "startLine": 5,
            "endLine": 6
        },
        "instruction": "RUN",
        "args": [
            "more_stuff"
        ]
    },
    {
        "line_range": {
            "startLine": 7,
            "endLine": 9
        },
        "instruction": "RUN",
        "args": [
            "apk",
            "add",
            "--no-cache",
            "curl",
            "\u0026\u0026",
            "\\",
            "curl",
            "--insecure",
            "-o",
            "/tmp/example.txt",
            "https://example.com",
            "\u0026\u0026",
            "\\",
            "cat",
            "/tmp/example.txt"
        ]
    }
]
	count(result) == 1
}