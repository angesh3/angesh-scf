import pytest
from src.providers.aws.scanner import AWSComplianceScanner

@pytest.fixture
def scanner():
    return AWSComplianceScanner()

async def test_scan_resource(scanner):
    findings = await scanner.scan_resource("test-bucket")
    assert isinstance(findings, dict)
    assert "resource_type" in findings

async def test_scan_account( 