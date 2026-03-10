# tfoutdated integration tests

Real-world test suite for [tfoutdated](https://github.com/AnassKartit/tfoutdated) — runs `scan` and `fix` against HCL, CDKTF, and Terragrunt configs across AWS, Azure, and GCP on every push.

## What's tested

### HCL (.tf files)

| Cloud | Modules | Versions |
|-------|---------|----------|
| **AWS** | EKS, S3, VPC | 19.0→latest, 3.0→latest, 4.0→latest |
| **Azure** | VNet (AVM), ACR (AVM), Key Vault (AVM) | 0.7→latest, 0.4→latest, 0.5→latest |
| **GCP** | GKE, Cloud NAT, Network | 28.0→latest, 4.0→latest, 8.0→latest |

### CDKTF (cdktf.json + package.json)

| Cloud | Modules | Providers |
|-------|---------|-----------|
| **AWS** | EKS, VPC, S3 (via cdktf.json) | `@cdktf/provider-aws` + `hashicorp/aws` |
| **Azure** | VNet (AVM), ACR (AVM) (via cdktf.json) | `hashicorp/azurerm` |

### Terragrunt (terragrunt.hcl)

| Cloud | Module | Source |
|-------|--------|--------|
| **AWS** | EKS | `tfr:///terraform-aws-modules/eks/aws?version=19.0.0` |
| **Azure** | VNet (AVM) | `tfr:///Azure/avm-res-network-virtualnetwork/azurerm?version=0.7.0` |

## Workflow

1. **Scan** — Detects outdated deps and breaking changes
2. **Fix** — Applies version bumps, variable renames, provider constraint updates
3. **Diff** — Shows exactly what changed in .tf, cdktf.json, package.json, and terragrunt.hcl

Check the [Actions tab](../../actions) for latest results.
