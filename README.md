# The Polyglot Fraud Auditor 🕵️‍♂️🛡️

### **Multi-Cloud Agentic AI Ecosystem (Java + Python + Kafka)**
**Architected for Zero-Trust Security on Azure & AWS | Orchestrated on Oracle K8s**

---

## 🌟 Overview
The **Polyglot Fraud Auditor** is a sophisticated, event-driven ecosystem designed to detect and investigate financial anomalies in real-time. This project bridges the gap between high-throughput enterprise messaging (**Java 21 / Spring Boot**) and autonomous AI reasoning (**Python 3.12 / LangGraph**). 

It is a "Cloud-Agnostic" masterpiece, strategically utilizing the **Free Tiers** of three major providers to build a production-grade system without infrastructure costs.

---

## 📂 Repository layout

| README role | Module | Purpose |
| :--- | :--- | :--- |
| **Transaction Ingress (Java)** | [`services/java-transaction-producer`](services/java-transaction-producer/) | Spring Boot API: capture transactions and publish events to AWS SQS. |
| **Autonomous Auditing (Python)** | [`services/python-fraud-auditor`](services/python-fraud-auditor/) | Fraud evaluation, SQS worker processing, and FastAPI endpoints for local/dev validation. |
| **Infrastructure as Code** | [`infrastructure/terraform`](infrastructure/terraform/) | Multi-cloud infrastructure definitions (AWS, Azure, OCI) and orchestration scripts. |
| **Kubernetes (OKE)** | [`infrastructure/k8s/helm/java-transaction-producer`](infrastructure/k8s/helm/java-transaction-producer/) | Helm chart for the Java producer on-cluster. |

---

## 🏗️ Architecture & Data Flow



1.  **Transaction Ingress (Java):** A Spring Boot microservice accepts transaction requests and publishes canonical transaction events to **AWS SQS**.
2.  **Autonomous Auditing (Python):** The Python auditor consumes SQS events and evaluates risk decisions using deterministic baseline rules.
3.  **Audit Persistence (AWS):** Audit outcomes and reasoning are stored in **AWS DynamoDB** for downstream workflows and investigation.

---

## 🛠️ The Tech Stack

| Domain | Technologies | Certification Alignment |
| :--- | :--- | :--- |
| **Compute** | Oracle OKE (Kubernetes), Docker | **CKAD (Certified K8s Developer)** |
| **Messaging** | AWS SQS | **AWS Developer Associate** |
| **Intelligence** | Python, deterministic fraud rules | **AI / Solutions Architect** |
| **Infrastructure** | Terraform, GitHub Actions, S3 + DynamoDB | **AWS Solutions Architect** |
| **Identity** | Microsoft Entra ID (Workload Identity) | **Zero-Trust Security** |

---

## 🔐 The "Architect's Flex": Cross-Cloud Identity
This project eliminates the need for hardcoded secrets. 
- **Workload Identity Federation:** The OCI K8s cluster uses an OIDC handshake with **Microsoft Entra ID**. 
- **Secretless Access:** The Java and Python apps assume **Azure Managed Identities** and **AWS IAM Roles** dynamically, demonstrating mastery of enterprise-grade security protocols.

---

## 📈 System Logic (Mermaid Flowchart)

```mermaid
graph LR
    Client[Client] -->|POST transaction| JavaApi[JavaTransactionAPI]
    JavaApi -->|publish event| SQS[AWS SQS]
    SQS -->|consume message| PyAuditor[PythonFraudAuditor]
    PyAuditor -->|persist audit result| DDB[(AWS DynamoDB)]
```