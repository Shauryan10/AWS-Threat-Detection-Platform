# 🛡️ Cloud Threat Detection & Auto-Response Platform

<div align="center">

![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge\&logo=amazonaws)
![Terraform](https://img.shields.io/badge/Terraform-IaC-purple?style=for-the-badge\&logo=terraform)
![Docker](https://img.shields.io/badge/Docker-Containers-blue?style=for-the-badge\&logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-blue?style=for-the-badge\&logo=kubernetes)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-black?style=for-the-badge\&logo=githubactions)
![Trivy](https://img.shields.io/badge/Trivy-Security-green?style=for-the-badge)
![Grafana](https://img.shields.io/badge/Grafana-Monitoring-orange?style=for-the-badge\&logo=grafana)
![Prometheus](https://img.shields.io/badge/Prometheus-Metrics-red?style=for-the-badge\&logo=prometheus)

</div>

---

# 📌 Project Overview

The **Cloud Threat Detection & Auto-Response Platform** is a cloud-native DevSecOps project designed to detect suspicious AWS activities, automate incident processing, and integrate modern cloud security engineering practices.

This platform combines:

* ☁️ AWS Cloud Security
* ⚙️ Infrastructure as Code (Terraform)
* 🐳 Docker Containerization
* ☸️ Kubernetes Orchestration
* 🔍 DevSecOps Security Scanning
* 📊 Monitoring & Observability
* 🚀 CI/CD Automation

The project simulates real-world cloud security workflows used by SOC teams, DevSecOps engineers, and cloud security professionals.

---

# 🎯 Key Features

## 🔐 Threat Detection

* Detects suspicious AWS events
* Simulated CloudTrail security monitoring
* Event-driven architecture using EventBridge

## ⚡ Auto-Response Engine

* Severity classification
* Automated incident processing
* SNS email alerting
* DynamoDB incident logging

## 🏗️ Infrastructure as Code

Provisioned using Terraform:

* AWS Lambda
* SNS
* EventBridge
* DynamoDB
* IAM Roles & Policies

## 🐳 Containerization

* Dockerized threat detection environment
* Secure lightweight container builds
* Non-root container execution

## ☸️ Kubernetes Deployment

* Minikube cluster deployment
* Kubernetes services & deployments
* Pod orchestration & scaling

## 🔍 DevSecOps Security

* Trivy vulnerability scanning
* GitHub Actions CI/CD pipeline
* Terraform validation automation

## 📊 Monitoring & Observability

* Prometheus metrics collection
* Grafana dashboards
* Kubernetes monitoring

---

# 🧠 Architecture

```text
GitHub Push
      ↓
GitHub Actions CI/CD
      ↓
Trivy Security Scan
      ↓
Terraform Infrastructure
      ↓
AWS Threat Detection Pipeline
      ↓
Docker Containerization
      ↓
Kubernetes Deployment
      ↓
Prometheus Monitoring
      ↓
Grafana Visualization
```

---

# 🛠️ Tech Stack

| Category             | Technologies          |
| -------------------- | --------------------- |
| Cloud                | AWS                   |
| IaC                  | Terraform             |
| CI/CD                | GitHub Actions        |
| Containers           | Docker                |
| Orchestration        | Kubernetes (Minikube) |
| Security Scanning    | Trivy                 |
| Monitoring           | Prometheus            |
| Visualization        | Grafana               |
| Programming Language | Python                |
| Serverless           | AWS Lambda            |

---

# 📂 Project Structure

```text
threat-detection-response/
│
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   └── variables.tf
│
├── lambda/
│   ├── handler.py
│   └── test_runner.py
│
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── Dockerfile
├── .gitignore
└── README.md
```

---

# 🚀 Setup Instructions

## 1️⃣ Clone Repository

```bash
git clone <repository-url>
cd threat-detection-response
```

---

## 2️⃣ Terraform Deployment

```bash
cd terraform
terraform init
terraform apply
```

---

## 3️⃣ Docker Build

```bash
docker build -t threat-platform:latest .
```

---

## 4️⃣ Kubernetes Deployment

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

Check pods:

```bash
kubectl get pods
```

---

## 5️⃣ Run Security Scans

### Filesystem Scan

```bash
trivy fs .
```

### Docker Image Scan

```bash
trivy image threat-platform
```

---

# 📊 Monitoring Stack

## Install Prometheus

```bash
helm install prometheus prometheus-community/prometheus
```

## Install Grafana

```bash
helm install grafana grafana/grafana
```

Access Grafana:

```text
http://localhost:3000
```

---

# 🔒 Security Hardening Implemented

✅ Non-root Docker containers
✅ Alpine-based minimal images
✅ Kubernetes resource limits
✅ Read-only root filesystem
✅ Trivy vulnerability scanning
✅ IAM least-privilege concepts
✅ Infrastructure validation pipeline

---

# 📈 Learning Outcomes

This project helped in understanding:

* Cloud Security Engineering
* DevSecOps workflows
* Infrastructure as Code
* Container Security
* Kubernetes orchestration
* CI/CD automation
* Monitoring & observability
* Security scanning pipelines

---

# 📸 Screenshots

> Add screenshots here:

* AWS Lambda
* EventBridge
* DynamoDB incidents
* SNS alerts
* GitHub Actions
* Trivy scans
* Kubernetes pods
* Grafana dashboards

---

# ⚠️ Challenges Faced During Development

Building this project involved multiple real-world engineering and debugging challenges across cloud infrastructure, DevSecOps, Kubernetes, and monitoring systems.

## ☁️ AWS Event Detection Challenges

* AWS Console login events were inconsistent during testing
* EventBridge rule matching required multiple debugging iterations
* CloudTrail event propagation delays created testing difficulties
* SNS and Lambda permissions required careful IAM configuration

## 🐳 Docker & Containerization Challenges

* Running AWS Lambda-style code inside Docker containers initially caused environment variable and region issues
* Container runtime failed due to missing AWS configuration values
* Security hardening required modifying containers to run as non-root users

## ☸️ Kubernetes Challenges

* Docker Desktop Kubernetes setup failed because of image download/network issues
* Minikube setup required reconfiguration of local Docker environment
* Kubernetes deployment YAML debugging involved troubleshooting empty manifests and pod startup issues
* Understanding Kubernetes networking and services required hands-on experimentation

## 🔍 CI/CD & GitHub Actions Challenges

* GitHub Actions pipeline initially failed because Lambda ZIP artifacts were ignored by `.gitignore`
* Terraform validation failed due to missing build artifacts
* YAML indentation and workflow debugging required careful troubleshooting

## 📊 Monitoring & Observability Challenges

* Grafana initially failed to connect to Prometheus due to incorrect service URLs
* Prometheus services needed verification and troubleshooting inside Kubernetes
* Understanding the separation between AWS infrastructure monitoring and Kubernetes observability was an important learning experience

## 🔒 Security Challenges

* Trivy scans identified container vulnerabilities that required Docker image hardening
* Kubernetes security contexts and resource limits required additional configuration
* Secure container practices such as read-only filesystem and non-root execution needed to be implemented carefully

## 🧠 Key Learning Outcome

One of the biggest lessons from this project was learning how to systematically debug distributed cloud-native systems involving:

* AWS services
* Infrastructure as Code
* Containers
* Kubernetes
* CI/CD pipelines
* Monitoring stacks

This project significantly improved practical problem-solving, troubleshooting, and DevSecOps engineering skills.

---

# 🔮 Future Enhancements

* Integrate AWS CloudWatch with Grafana
* Add real CloudTrail event ingestion
* Implement automated remediation actions
* Add EKS deployment support
* Integrate SIEM tools
* Add REST API dashboard
* Add RBAC authentication

---

# 👨‍💻 Author

**Shauryan Shindhu**

B.Tech CSE (IoT & Cybersecurity including Blockchain Technology)
Amity University Uttar Pradesh

---

# ⭐ Final Note

This project demonstrates practical exposure to:

* Cloud Security
* DevSecOps
* Infrastructure Automation
* Kubernetes
* CI/CD
* Monitoring & Observability

while following modern cloud-native engineering practices.
