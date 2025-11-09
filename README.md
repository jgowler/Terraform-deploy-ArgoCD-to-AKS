# Terraform: Deploy ArgoCD to AKS
---

The reasson for this project is to create an AKS cluster and deploy ArgoCD using Helm and using a GitHub repository to deploy apps using GitOps.

---
## Tools:
---

The following tools will be used in this project:

```
Terraform
Azure CLI
Helm
```
Along with the above a `Service Principal` will be used to connect to Azure and deploy resources to an existing `Resource Group`. The purpose of this is to grant as few permissions to the subscription as possible whilst also allowing the SP to do what it needs to do.

