import sys
import subprocess
from pathlib import Path


FACTORIO_CURRENT_LOG = Path.home() / "AppData/Roaming/Factorio/factorio-current.log"
MOD_NAME = "commander"


if __name__ == '__main__':
    try:
        print(f"Watching '{FACTORIO_CURRENT_LOG}'...")
        command = f"& {{Get-Content {FACTORIO_CURRENT_LOG} -Wait | "\
                  f"Select-String -Pattern __{MOD_NAME}__ | "\
                  f"foreach{{ $_.Line.trim()}} }}"
        subprocess.run(["powershell.exe", "-Command", command])
    except KeyboardInterrupt:
        print(f"Quit watching '{FACTORIO_CURRENT_LOG}'")
