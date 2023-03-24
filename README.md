# terraform-aws-metabase
This is a module for self-hosting metabase on AWS.

Before using it you need:
1. A (sub)domain to host this under
2. An SSL certificate for that domain hosted in AWS Certificate Manager
3. A Route 53 hosted zone

Set up a directory like the one in `/example` and modify the values in `main.tf` to suit your case and aws region.