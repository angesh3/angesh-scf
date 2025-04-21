from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from typing import List, Dict
import asyncio

from src.providers.aws.scanner import AWSComplianceScanner

app = FastAPI(title="Security Compliance Framework API")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize scanner
scanner = AWSComplianceScanner()

@app.get("/")
async def root():
    return {"message": "Security Compliance Framework API"}

@app.post("/scan/aws")
async def scan_aws():
    """Trigger an AWS account scan."""
    try:
        findings = await scanner.scan_account()
        return {
            "status": "success",
            "findings": findings
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/findings")
async def get_findings():
    """Get current findings."""
    findings = await scanner.get_findings()
    return {
        "status": "success",
        "findings": findings
    }

@app.get("/resource/{resource_id}")
async def get_resource_findings(resource_id: str):
    """Get findings for a specific resource."""
    findings = await scanner.scan_resource(resource_id)
    return {
        "status": "success",
        "findings": findings
    } 