```
key=$(terraform output -raw terraform-static-key)
secret=$(terraform output -raw terraform-static-key-secret)
export AWS_ACCESS_KEY_ID=$key
export AWS_SECRET_ACCESS_KEY=$secret
terraform output -raw terraform-key-json > sa_key.json
```

```
key=$(terraform output -raw terraform-viewer-static-key)
secret=$(terraform output -raw terraform-viewer-static-key-secret)
export AWS_ACCESS_KEY_ID=$key
export AWS_SECRET_ACCESS_KEY=$secret
terraform output -raw terraform-viewer-key-json > sa_key.json
```