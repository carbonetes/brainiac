package lib.docker.CB_DKR_014

test_certificate_validation_disabled_with_curl {
	result := passed with input as [
    {
        "line_range": {
            "startLine": 1,
            "endLine": 3
        },
        "instruction": "FROM",
        "args": [
            "alpine:3.14",
            "#",
            "This",
            "instruction",
            "uses",
            "wget",
            "with",
            "--no-check-certificate"
        ]
    },
    {
        "line_range": {
            "startLine": 4,
            "endLine": 6
        },
        "instruction": "RUN",
        "args": [
            "apk",
            "add",
            "--no-cache",
            "wget",
            "\u0026\u0026",
            "\\",
            "wget",
            "-O",
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
            "endLine": 3
        },
        "instruction": "FROM",
        "args": [
            "alpine:3.14",
            "#",
            "This",
            "instruction",
            "uses",
            "wget",
            "with",
            "--no-check-certificate"
        ]
    },
    {
        "line_range": {
            "startLine": 4,
            "endLine": 6
        },
        "instruction": "RUN",
        "args": [
            "apk",
            "add",
            "--no-cache",
            "wget",
            "\u0026\u0026",
            "\\",
            "wget",
            "--no-check-certificate",
            "-O",
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