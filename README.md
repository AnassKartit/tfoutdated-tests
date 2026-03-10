# tfoutdated integration tests

Real-world test suite for [tfoutdated](https://github.com/AnassKartit/tfoutdated) — runs `scan` and `fix` against real Terraform configs across AWS, Azure, and GCP on every push.

## What's tested

| Cloud | Modules | Versions |
|-------|---------|----------|
| **AWS** | EKS, S3, VPC | 19.0→latest, 3.0→latest, 4.0→latest |
| **Azure** | VNet (AVM), ACR (AVM), Key Vault (AVM) | 0.7→latest, 0.4→latest, 0.5→latest |
| **GCP** | GKE, Cloud NAT, Network | 28.0→latest, 4.0→latest, 8.0→latest |

## Workflow

1. **Scan** — Detects outdated deps and breaking changes (table, JSON, markdown)
2. **Fix** — Applies version bumps, variable renames, provider constraint updates
3. **Diff** — Shows exactly what changed

Check the [Actions tab](../../actions) for latest results.
