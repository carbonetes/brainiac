package lib.docker.CB_DKR_015

test_certificate_validation_disabled_with_pip {
	result := passed with input as [
    {
        "line_range": {
            "startLine": 1,
            "endLine": 3
        },
        "instruction": "FROM",
        "args": [
            "python:3.8-alpine",
            "#",
            "Install",
            "CA",
            "certificates",
            "package"
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
            "ca-certificates",
            "#",
            "This",
            "instruction",
            "uses",
            "pip",
            "with",
            "and",
            "proper",
            "certificate",
            "validation"
        ]
    }
]
	count(result) == 1
}

test_certificate_validation_not_disabled_with_pip {
	result := failed with input as [
    {
        "line_range": {
            "startLine": 1,
            "endLine": 3
        },
        "instruction": "FROM",
        "args": [
            "python:3.8-alpine",
            "#",
            "Install",
            "CA",
            "certificates",
            "package"
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
            "ca-certificates",
            "#",
            "This",
            "instruction",
            "uses",
            "pip",
            "with",
            "--trusteds-host",
            "and",
            "proper",
            "certificate",
            "validation"
        ]
    },
    {
        "line_range": {
            "startLine": 7,
            "endLine": 8
        },
        "instruction": "RUN",
        "args": [
            "pip",
            "install",
            "--trusted-host",
            "pypi.python.org",
            "--cert",
            "/etc/ssl/certs/ca-certificates.crt",
            "some-package"
        ]
    }
]
	count(result) == 1
}