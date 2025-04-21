from abc import ABC, abstractmethod
from typing import Dict, List, Optional

class ComplianceScanner(ABC):
    """Base class for compliance scanners."""
    
    @abstractmethod
    async def scan_resource(self, resource_id: str) -> Dict:
        """Scan a single resource for compliance."""
        pass

    @abstractmethod
    async def scan_account(self) -> List[Dict]:
        """Scan entire account for compliance."""
        pass

    @abstractmethod
    async def get_findings(self) -> List[Dict]:
        """Retrieve compliance findings."""
        pass 