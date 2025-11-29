param()

function Update-RmuxPaneTitle {
    try {
        $cwdLeaf = Split-Path -Leaf (Get-Location)
        $lastCmd = (Get-History -Count 1 | Select-Object -ExpandProperty CommandLine)
        $title = if ($lastCmd) { "$cwdLeaf: $lastCmd" } else { $cwdLeaf }
        rmux set-pane-title $title | Out-Null
    } catch {
        # Ignore errors if rmux or session is not running
    }
}

# Usage:
# 1) Add to your $PROFILE (Microsoft.PowerShell_profile.ps1):
#    . "$PSScriptRoot\rmux-title.ps1"
#    function Prompt {
#        Update-RmuxPaneTitle
#        "PS " + (Get-Location) + "> "
#    }
# 2) Ensure a running rmux session server and, if needed, set $env:RMUX_TARGET_SESSION.