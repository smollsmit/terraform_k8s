# Cloudflare operations

## Import zone from Cloudflare
```
terraform import -var-file=tfvars/dev.tfvars module.cloudflare.cloudflare_zone.zone <zone_id>
```