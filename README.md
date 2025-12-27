# automation

A collection of **automation + infrastructure code** (Terraform, Python, and related tooling) for multiple real-world use cases.

> 📌 Note: This repo is organized as a set of independent projects (folders). Each folder typically represents a specific automation use case or infrastructure component.

---

## What you’ll find in this repo

From the folder structure, this repository includes projects such as: 
- **Terraform (IaC)**
  - `azure-tf/tf_files` — Terraform files for Azure resources (IaC templates).
  - `nailbiter-nodegroup-tf` — Terraform for node group provisioning (likely Kubernetes/EKS-style node groups). 

- **Cluster / Platform Automation**
  - `Quickwork-Rabbitmq-Cluster` — Setup/automation related to a RabbitMQ cluster.
  - `new-mongo-ansible` — Ansible automation for MongoDB (installation/config management). 
- **AWS / Serverless Utilities**
  - `jenkins-notification-lambda` — AWS Lambda utility for Jenkins notifications (event-driven alerts). 

- **Ops / Tooling**
  - `metabase` — Assets/config related to Metabase deployment/ops. 
  - `hexolt`, `tm` — Additional automation/tooling folders (purpose depends on internal structure).
---

## Repo structure

```bash
automation/
├── Quickwork-Rabbitmq-Cluster/
├── azure-tf/
│   └── tf_files/
├── hexolt/
├── jenkins-notification-lambda/
├── metabase/
├── nailbiter-nodegroup-tf/
├── new-mongo-ansible/
└── tm/
