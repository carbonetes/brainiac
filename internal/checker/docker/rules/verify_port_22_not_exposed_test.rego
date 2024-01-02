package lib.docker.CB_DKR_001

test_port_22_not_exposed {
	result := passed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 1,
			},
			"instruction": "FROM",
			"args": [
				"--platform=linux/arm64/v8",
				"arm64v8/eclipse-temurin:8u352-b08-jre",
				"as",
				"builder",
			],
		},
		{
			"line_range": {
				"startLine": 2,
				"endLine": 2,
			},
			"instruction": "WORKDIR",
			"args": ["application"],
		},
		{
			"line_range": {
				"startLine": 5,
				"endLine": 5,
			},
			"instruction": "COPY",
			"args": [
				"--from=builder",
				"application/dependencies/",
				"./",
			],
		},
		{
			"line_range": {
				"startLine": 6,
				"endLine": 6,
			},
			"instruction": "COPY",
			"args": [
				"--from=builder",
				"application/snapshot-dependencies/",
				"./",
			],
		},
		{
			"line_range": {
				"startLine": 7,
				"endLine": 7,
			},
			"instruction": "COPY",
			"args": [
				"--from=builder",
				"application/spring-boot-loader/",
				"./",
			],
		},
		{
			"line_range": {
				"startLine": 8,
				"endLine": 8,
			},
			"instruction": "COPY",
			"args": [
				"--from=builder",
				"application/application/",
				"./",
			],
		},
		{
			"line_range": {
				"startLine": 11,
				"endLine": 11,
			},
			"instruction": "ENTRYPOINT",
			"args": ["[\"java\",\"-Dspring.profiles.active=${PROFILE}\",\"org.springframework.boot.loader.JarLauncher\"]"],
		},
	]
	count(result) == 1
}

test_port_22_exposed {
	result := failed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 1,
			},
			"instruction": "FROM",
			"args": [
				"--platform=linux/arm64/v8",
				"arm64v8/eclipse-temurin:8u352-b08-jre",
				"as",
				"builder",
			],
		},
		{
			"line_range": {
				"startLine": 2,
				"endLine": 2,
			},
			"instruction": "WORKDIR",
			"args": ["application"],
		},
		{
			"line_range": {
				"startLine": 3,
				"endLine": 3,
			},
			"instruction": "EXPOSE",
			"args": ["22"],
		},
		{
			"line_range": {
				"startLine": 5,
				"endLine": 5,
			},
			"instruction": "COPY",
			"args": [
				"--from=builder",
				"application/dependencies/",
				"./",
			],
		},
		{
			"line_range": {
				"startLine": 6,
				"endLine": 6,
			},
			"instruction": "COPY",
			"args": [
				"--from=builder",
				"application/snapshot-dependencies/",
				"./",
			],
		},
		{
			"line_range": {
				"startLine": 7,
				"endLine": 7,
			},
			"instruction": "COPY",
			"args": [
				"--from=builder",
				"application/spring-boot-loader/",
				"./",
			],
		},
		{
			"line_range": {
				"startLine": 8,
				"endLine": 8,
			},
			"instruction": "COPY",
			"args": [
				"--from=builder",
				"application/application/",
				"./",
			],
		},
		{
			"line_range": {
				"startLine": 11,
				"endLine": 11,
			},
			"instruction": "ENTRYPOINT",
			"args": ["[\"java\",\"-Dspring.profiles.active=${PROFILE}\",\"org.springframework.boot.loader.JarLauncher\"]"],
		},
	]
	count(result) == 1
}
