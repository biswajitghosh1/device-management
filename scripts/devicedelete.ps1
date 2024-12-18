# Define the Workspace ONE API endpoint and API key
$apiUrl = "https://as63.airwatchportals.com/api"
$apiKey = "OyeGrzrEI7RBQWVL5VcJrBqtvit2EZqGiQqyEO5Zwb8="

# Function to delete a device by its ID
function Delete-Device {
    param (
        [string]$deviceId
    )

    $headers = @{
        "Authorization" = "Bearer $apiKey"
        "Content-Type"  = "application/json"
    }

    $response = Invoke-RestMethod -Uri "$apiUrl/devices/$deviceId" -Method Delete -Headers $headers

    if ($response.StatusCode -eq 204) {
        Write-Output "Device $deviceId deleted successfully."
    } else {
        Write-Output "Failed to delete device $deviceId. Status code: $($response.StatusCode)"
    }
}

# Main script
$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$csvFilePath = Join-Path -Path $scriptDirectory -ChildPath "device_ids.csv"
$deviceIds = Import-Csv -Path $csvFilePath

foreach ($device in $deviceIds) {
    Delete-Device -deviceId $device.DeviceId
}