Toptal Project

Technologies:
- GKE (Google Cloud) 
- GitHub Actions (CI/CD)
- Skaffold (CI/CD) 
- Terraform (IaC)
- Terraform Provider/Provisioners+Shell Scripts (Configuration)
- Terragrunt (Terra-services)
- Helm (Package Manager)
- Prometheus (Monitoring)
- Backups (Velero)
- PLG (Logging)
- GCR (Container registry)


Local tool requirement:
- Terraform
- Velero
- Gcloud with kubernetes, storage, gce, gcr and network access.

Usage:

Create Infraestructure
1.- Authenticate with gcloud 
2.- Terragrunt run-all plan
3.- Terragrunt run-all apply

Use CI/CD
apply a change and commit to master

The repo that I ussed for all the project is this one: https://github.com/bonildav/TopTal-project and for the app https://github.com/bonildav/bank-of-anthos

<img width="640" alt="Deployment Diagram" src="https://user-images.githubusercontent.com/40408393/121459876-a6b06e80-c971-11eb-87c7-719c4b2a2579.png">
