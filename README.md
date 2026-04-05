# Polyglot Fraud Auditor

Multi-cloud fraud review flow: **Java (Spring Boot)** ingests transactions and publishes events to **AWS SQS**; a **Python** agent on **AWS Lambda** performs RAG + LLM risk assessment and calls back to an **Azure** webhook to finalize status.

## Repository layout

| Path | Purpose |
|------|---------|
| `services/java-transaction-engine` | REST API, validation, persistence, SQS publish, webhook receiver |
| `services/python-agent-auditor` | Lambda handler / local FastAPI, RAG, Bedrock or Azure OpenAI + HF auxiliary tasks |
| `infrastructure/terraform` | SQS, Lambda, IAM; Azure resources as you add them |
| `infrastructure/k8s` | Helm charts for containerized Java (or related) workloads |
| `ai-research/prompts` | Versioned system / user prompts |
| `ai-research/evals` | Scenarios, golden outputs, regression checks for the agent |
| `monitoring` | Dashboards (e.g. Grafana JSON), OTel/Prometheus notes |

## Local development

**Java (from `services/java-transaction-engine`):**

```bash
mvn spring-boot:run
```

Optional: set `SQS_TRANSACTION_EVENTS_URL` and `AWS_ENDPOINT` (e.g. LocalStack) to publish real messages; if unset, the engine logs and skips SQS.

**Python agent (from `services/python-agent-auditor`):**

Uses [uv](https://docs.astral.sh/uv/) for environments and runs (install: `curl -LsSf https://astral.sh/uv/install.sh | sh` or your package manager).

```bash
cd services/python-agent-auditor
uv sync
# optional: match AWS Lambda runtime, e.g. uv sync --python 3.12
cp .env.example .env
uv run agent-api
```

- Tests: `uv run pytest`
- API: `http://127.0.0.1:8000/docs`
- Lambda handler entrypoint: `fraud_auditor.handler.lambda_handler` (deploy as a package; `uv run` installs the project into the managed env).

Lockfile `uv.lock` is committed so installs are reproducible; refresh with `uv lock` after dependency changes.

## Next steps

- Wire Postgres (or pgvector) for transactions + RAG, Terraform for SQS/Lambda, and LLM/guardrails in the Python path.
- Add architecture diagrams and a cost manifest (FinOps) in this README as the design stabilizes.
