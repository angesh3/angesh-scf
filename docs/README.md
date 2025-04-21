# Security Compliance Framework (SCF)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

The Security Compliance Framework (SCF) is an automated solution designed to streamline the process of auditing, enforcing, and reporting on security compliance standards within cloud infrastructure environments. Initially focusing on AWS, the framework aims to help organizations maintain a robust security posture by continuously monitoring against established benchmarks and best practices.

## Business Use Case

In today's cloud-centric world, maintaining security and compliance across complex infrastructure is paramount but challenging. Businesses need to:
- **Ensure Adherence to Standards**: Meet industry regulations (like CIS Benchmarks, GDPR, HIPAA, etc.) and internal security policies.
- **Reduce Manual Effort**: Automate repetitive compliance checks, freeing up security teams for higher-value tasks.
- **Improve Security Posture**: Proactively identify and address misconfigurations and vulnerabilities before they can be exploited.
- **Gain Visibility**: Provide clear reporting and dashboards for stakeholders to understand the current compliance status.
- **Scale Security**: Manage compliance effectively as cloud environments grow and change.

SCF addresses these needs by providing a centralized, automated platform for cloud security compliance management.

## The Problem & Our Solution

**Problem**: Manually auditing cloud resources against security benchmarks is time-consuming, prone to human error, inconsistent, and scales poorly. Tracking compliance drift and generating accurate reports adds further complexity.

**Solution**: SCF offers an automated, framework-based approach. It connects to cloud environments (starting with AWS), scans resources against defined rules (based on standards like CIS Benchmarks), identifies non-compliant resources, and provides findings through an API and a web dashboard. This allows for continuous monitoring and faster remediation cycles.

## Our Approach

SCF employs a modular and extensible architecture:
- **Provider-Based Design**: Core scanning logic is separated from cloud-specific implementations. New cloud providers (like Azure, GCP) can be added by implementing a specific provider module.
- **API-Driven**: A FastAPI backend exposes endpoints for triggering scans, retrieving findings, and managing configurations.
- **Decoupled Frontend**: A React/Vite-based dashboard interacts with the API to visualize compliance status and findings.
- **Containerized Deployment**: Leverages Docker and Docker Compose for consistent setup and deployment across different environments.

## Key Concepts

- **Compliance Scanner**: The core engine responsible for executing checks against cloud resources.
- **Provider**: A module implementing the necessary logic to interact with a specific cloud platform's APIs (e.g., `AWSComplianceScanner`).
- **Compliance Rule**: A specific check or policy derived from a security benchmark (e.g., "Ensure S3 buckets are not publicly accessible"). *(Note: Rule definition/management is a potential future enhancement)*.
- **Finding**: The result of a compliance check on a specific resource, indicating whether it is compliant or non-compliant and providing relevant details.
- **Resource Scanning**: Scanning individual cloud resources for compliance status.
- **Account Scanning**: Scanning all relevant resources within a cloud account.

## What Makes SCF Unique?

While various compliance tools exist, SCF aims to differentiate itself through:
- **Extensibility**: Designed from the ground up with a provider model for easier integration of multiple cloud platforms.
- **Open Framework**: Provides a base structure that can be customized and extended with specific rules and integrations.
- **Integrated Dashboard**: Offers a built-in web interface for visualizing compliance data (unlike some tools that are purely CLI/API based).

*(Note: Further differentiation can be achieved by focusing on specific benchmark integrations, remediation workflows, or reporting capabilities as the project evolves.)*

## Architecture

SCF utilizes a microservices-oriented architecture orchestrated using Docker Compose:

1.  **API (FastAPI)**:
    *   Written in Python using FastAPI.
    *   Handles incoming requests, interacts with cloud providers via scanners, and potentially stores/retrieves data from the database.
    *   Serves the REST API for scans and findings.
    *   Container: `api` (built from `./Dockerfile`)
    *   Accessible on host port `8000`.

2.  **Dashboard (React/Vite)**:
    *   A web-based frontend built with React and Vite.
    *   Communicates with the API service (`http://api:8000` internally, configured via `REACT_APP_API_URL`).
    *   Provides visualization of compliance status and findings.
    *   Container: `dashboard` (built from `./dashboard/Dockerfile`)
    *   Accessible on host port `3000`.

3.  **Database (PostgreSQL)**:
    *   Used for persistent storage of findings, configurations, or inventory data (usage may evolve).
    *   Container: `db` (using official `postgres:13` image).

4.  **Cache/Queue (Redis)**:
    *   Included for potential future use cases like caching API responses, managing distributed tasks, or handling asynchronous operations.
    *   Container: `redis` (using official `redis:6` image).

*(Suggestion: Include a visual architecture diagram here, e.g., using Mermaid syntax or linking an image file.)*

```mermaid
graph TD
    subgraph Host Machine
        LB(Load Balancer/User Browser)
    end

    subgraph Docker Network
        subgraph API Service (Port 8000)
            API[FastAPI App]
        end

        subgraph Dashboard Service (Port 5173 internally)
            Dash[Vite Dev Server]
        end

        subgraph Database Service
            DB[(PostgreSQL)]
        end

        subgraph Cache Service
            Cache[(Redis)]
        end

        subgraph Cloud Provider (e.g., AWS)
            CloudAPI[Cloud APIs]
        end

        API -- interacts with --> CloudAPI
        API -- stores/retrieves --> DB
        API -- potentially uses --> Cache
        Dash -- fetches data from --> API
    end

    LB -- accesses --> HostPort3000[Port 3000] --> DashboardServicePort[Dashboard Service :5173]
    LB -- accesses --> HostPort8000[Port 8000] --> APIServicePort[API Service :8000]

    style CloudAPI fill:#f9f,stroke:#333,stroke-width:2px
```

## Code Walkthrough

A brief overview of the key directories and files:

- **`/` (Root Directory)**:
    - `docker-compose.yml`: Defines the services (api, dashboard, db, redis) and how they connect.
    - `Dockerfile`: Instructions to build the Docker image for the Python API service.
    - `pyproject.toml`: Defines Python project dependencies managed by Poetry.
    - `poetry.lock`: Locks Python dependencies to specific versions.
    - `.gitignore`: Specifies intentionally untracked files that Git should ignore.
    - `run.sh`: (If retained) Script for local setup/running outside Docker.

- **`/src`**: Contains the backend Python source code.
    - **`/src/api`**: FastAPI application.
        - `main.py`: Defines the FastAPI app instance, routes (endpoints), and potentially middleware.
    - **`/src/core`**: Core framework logic, independent of specific cloud providers or APIs.
        - **`/src/core/scanner`**:
            - `base.py`: Defines the abstract `ComplianceScanner` base class.
    - **`/src/providers`**: Cloud-specific implementations.
        - **`/src/providers/aws`**:
            - `scanner.py`: Contains the `AWSComplianceScanner` class (implementation needed).

- **`/dashboard`**: Contains the frontend React/Vite application source code.
    - `Dockerfile`: Instructions to build the Docker image for the Node.js dashboard service.
    - `package.json`: Defines Node.js project dependencies and scripts (`dev`, `build`).
    - `vite.config.js`: Vite build tool configuration.
    - **`/dashboard/src`**: React component source code.

- **`/tests`**: Contains automated tests.
    - `test_scanner.py`: Example tests for the compliance scanner functionality.

- **`/docs`**: Project documentation.
    - `README.md`: This file.

- **`/.github/workflows`**: (If exists) CI/CD pipeline definitions using GitHub Actions.

## How to Run (Docker Recommended)

### Prerequisites
- Docker: [Install Docker](https://docs.docker.com/get-docker/)
- Docker Compose: Usually included with Docker Desktop. [Install Docker Compose](https://docs.docker.com/compose/install/)
- Git: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- AWS Credentials: Configure your AWS credentials locally so `boto3` (used by the API) can access your account. The easiest way is often `aws configure` ([AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)). The API container *may* need these credentials mounted or passed as environment variables depending on its implementation.

### Running the Application
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/angesh3/angesh-scf.git
    cd angesh-scf
    ```
2.  **Start the services using Docker Compose:**
    This command will build the images for the `api` and `dashboard` services (if not already built) and start all defined services (`api`, `dashboard`, `db`, `redis`) in the background.
    ```bash
    docker-compose up -d --build
    ```
3.  **Access the services:**
    *   **Dashboard:** Open your web browser to `http://localhost:3000`
    *   **API:** The API is running at `http://localhost:8000`. API documentation (Swagger UI) should be available at `http://localhost:8000/docs`.

### Stopping the Application
```bash
docker-compose down
```
This will stop and remove the containers defined in the `docker-compose.yml` file. Add the `-v` flag (`docker-compose down -v`) to also remove the named volumes (like `postgres_data`).

## Development Setup (Alternative to Docker)

*(Note: Running directly without Docker might require manual setup of PostgreSQL, Redis, and careful management of Python/Node.js environments and dependencies.)*

### Prerequisites
- Python 3.9+ & Poetry
- Node.js 18+ & npm
- PostgreSQL Instance
- Redis Instance
- AWS Credentials configured

### Local Development Steps
1.  Set up and activate Python environment:
    ```bash
    # From project root
    python -m venv venv
    source venv/bin/activate # or venv\Scripts\activate on Windows
    pip install poetry
    poetry install
    ```
2.  Set up and run frontend:
    ```bash
    # From project root
    cd dashboard
    npm install
    # Ensure REACT_APP_API_URL is set appropriately if not running API on default localhost:8000
    npm run dev
    ```
3.  Set up and run backend:
    *   Ensure your PostgreSQL and Redis instances are running and accessible.
    *   Set environment variables like `DATABASE_URL` and `REDIS_URL` to point to your local instances.
    *   Run the FastAPI server:
        ```bash
        # From project root, with venv activated
        poetry run uvicorn src.api.main:app --reload --port 8000
        ```

## Configuration

Configuration is primarily managed through:
- **`docker-compose.yml`**: Defines service builds, ports, volumes, and environment variables for containerized deployment.
- **Environment Variables**: Passed to containers via `docker-compose.yml` or set directly when running locally (e.g., `DATABASE_URL`, `REDIS_URL`, `REACT_APP_API_URL`, AWS credentials).
- **Application Code**: Default settings or further configuration logic within the API or dashboard codebases.
- *(Potential Future: `config/*.yaml` files for scanner rules, etc., as mentioned in the original README - needs implementation)*

## API Documentation

When the API service is running, interactive API documentation (Swagger UI) is typically available at the `/docs` endpoint. For the default setup: `http://localhost:8000/docs`

## Contributing

Please refer to `CONTRIBUTING.md` for guidelines on contributing to this project. *(Note: Create this file if it doesn't exist)*

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. *(Note: Create this file if it doesn't exist)* 