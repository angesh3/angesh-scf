# Security Compliance Framework (SCF)

## Overview
The Security Compliance Framework (SCF) is an automated solution for auditing, enforcing, and reporting security compliance across cloud environments. This framework focuses on CIS Benchmarks and industry best practices to maintain a strong security posture.

## Features
- Automated compliance scanning against CIS Benchmarks
- Real-time resource inventory discovery
- Automated remediation capabilities
- Compliance drift detection
- Comprehensive reporting and dashboards
- CI/CD pipeline integration
- Multi-cloud support (AWS initially)

## Quick Start
1. Clone the repository
2. Install dependencies:
   ```bash
   poetry install
   ```
3. Configure AWS credentials:
   ```bash
   aws configure
   ```
4. Start the services:
   ```bash
   docker-compose up -d
   ```
5. Access the dashboard at http://localhost:3000

## Architecture
The framework consists of several key components:
- Core Scanner Engine
- Resource Inventory Manager
- Remediation Engine
- Reporting Service
- API Gateway
- Web Dashboard

## Development Setup
### Prerequisites
- Python 3.9+
- Node.js 16+
- Docker
- AWS Account
- PostgreSQL
- Redis

### Local Development
1. Set up Python environment:
   ```bash
   python -m venv venv
   source venv/bin/activate
   poetry install
   ```

2. Set up frontend:
   ```bash
   cd dashboard
   npm install
   npm run dev
   ```

3. Start backend services:
   ```bash
   poetry run uvicorn src.api.main:app --reload
   ```

## Configuration
Configuration is managed through environment variables and YAML files:
- `.env` - Environment variables
- `config/scanner.yaml` - Scanner configuration
- `config/rules.yaml` - Compliance rules

## API Documentation
API documentation is available at `/docs` when running the server.

## Contributing
See CONTRIBUTING.md for guidelines.

## License
MIT License 