package lib.kubernetes.CB_K8S_037

test_ingress_annotation_lua_snippets_passed {
            result := passed with input as{						                   
  "apiVersion": "networking.k8s.io/v1",
  "kind": "Ingress",
  "metadata": {
    "name": "example-ingress",
    "namespace": "developer",
    "annotations": {
      "kubernetes.io/ingress.class": "nginx",
      "nginx.ingress.kubernetes.io/rewrite-target": "/$2"
    }
  },
  "spec": {
    "rules": [
      {
        "http": {
          "paths": [
            {
              "path": "/test",
              "pathType": "Prefix",
              "backend": {
                "service": {
                  "name": "web",
                  "port": {
                    "number": 8080
                  }
                }
              }
            }
          ]
        }
      }
    ]
  }

				}

	count(result) == 1
}

test_ingress_annotation_lua_snippets_failed {
            result := failed with input as{					
  "apiVersion": "networking.k8s.io/v1",
  "kind": "Ingress",
  "metadata": {
    "name": "example-ingress",
    "namespace": "developer",
    "annotations": {
      "kubernetes.io/ingress.class": "nginx",
      "nginx.ingress.kubernetes.io/rewrite-target": "/$2",
      "alias-snippet": "location ^~ \"/test\" {\n  default_type 'text/plain';\n alias /var/run;\n}\n",
      "all-snippet": "location / {\n  return 200 'OK';\n}\n",
      "lua-snippet": "lua_package_path  \"/etc/nginx/lua/?.lua;;\";\nlocation / {\n  return 200 'OK';\n}\n"
    }
  },
  "spec": {
    "rules": [
      {
        "http": {
          "paths": [
            {
              "path": "/test",
              "pathType": "Prefix",
              "backend": {
                "service": {
                  "name": "web",
                  "port": {
                    "number": 8080
                  }
                }
              }
            }
          ]
        }
      }
    ]
  }
				}

	count(result) == 1
}