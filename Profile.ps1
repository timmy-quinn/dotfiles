
Write-Host "Loading custom profile"
# $env:PROFILE_TEST_MARKER = "loaded"

$pca = "C:\Proj\PCA\01_SW"

Write-Host "Loading custom profile"


function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
    $osc7 = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
    }
    "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) ";
}

# function Import-DotEnvFile {
#     param(
#         [Parameter(Mandatory)]
#         [string]$Path
#     )

#     if (-not (Test-Path $Path)) {
#         throw "Env file not found: $Path"
#     }

#     Get-Content $Path |
#         Where-Object { $_ -and -not $_.Trim().StartsWith('#') } |
#         ForEach-Object {
#             $line = $_.Trim()
#             $parts = $line -split '=', 2
#             if ($parts.Count -eq 2) {
#                 $name  = $parts[0].Trim()
#                 $value = $parts[1].Trim('"').Trim()
#                 $env:$name = $value
#             }
#         }
# }

# Usage:
Import-DotEnvFile "$HOME\API_TOKENS\my_env.env"

