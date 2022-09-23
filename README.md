# Terraform Google Cloud Service Bootstrap

Opinionated Google Cloud Service project initialization setup for service account impersonation. [Why use service account impersonation for on a GCP for terraform?](https://cloud.google.com/iam/docs/best-practices-service-accounts)

**What will this do?**

- A **Cloud Storage** bucket which should be used by your Terraform backend to hold the terraform state.
- A **Service Account** for Terraform to impersonate and access resources or perform actions as.
- Add **necessary roles to your user account** to facilitate Terraform's impersonation of the service account.

## Prerequisites

You must have the [`gcloud`](https://cloud.google.com/sdk/docs/install) CLI installed on your system. This project was last tested with these gcloud versions:

```
Google Cloud SDK 402.0.0
alpha 2022.09.12
beta 2022.09.12
bq 2.0.75
bundled-python3-unix 3.9.12
config-connector 1.93.0
core 2022.09.12
gcloud-crc32c 1.0.0
gsutil 5.13
```

A project must already be created in GCS.

## Usage

```bash
./bootstrap.sh GOOGLE_CLOUD_PROJECT_ID
```
