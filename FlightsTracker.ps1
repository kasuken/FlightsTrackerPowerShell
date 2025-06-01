# Flight Tracker PowerShell Script
# Uses AvionStack API to search and display flight information
# Author: GitHub Copilot
# Date: June 1, 2025

param(
    [Parameter(Mandatory = $false)]
    [string]$ApiKey,
    
    [Parameter(Mandatory = $false)]
    [string]$FlightCode
)

# Configuration
$ApiBaseUrl = "https://api.aviationstack.com/v1/flights"

# Function to get API key
function Get-ApiKey {
    param([string]$ProvidedKey)
    
    if ($ProvidedKey) {
        return $ProvidedKey
    }
    
    # Check for environment variable
    $envKey = $env:AVIATIONSTACK_API_KEY
    if ($envKey) {
        return $envKey
    }
    
    # Prompt user for API key
    $key = Read-Host "Please enter your AvionStack API key"
    if ([string]::IsNullOrEmpty($key)) {
        Write-Error "API key is required to use this script."
        exit 1
    }
    return $key
}

# Function to display airplane animation
function Show-AirplaneAnimation {
    $airplane = "✈️"
    $cloudLeft = "☁️"
    $cloudRight = "☁️"
    
    Write-Host "`n" -ForegroundColor Green
    
    # Animation frames
    for ($i = 0; $i -lt 3; $i++) {
        Clear-Host
        Write-Host "✈️ ═══════════════════════════════════════ ✈️" -ForegroundColor Cyan
        Write-Host "        🌟 FLIGHT TRACKER SCRIPT 🌟          " -ForegroundColor Cyan
        Write-Host "✈️ ═══════════════════════════════════════ ✈️" -ForegroundColor Cyan
        Write-Host ""
        
        # Create airplane animation based on frame
        switch ($i) {
            0 { 
                Write-Host "    $cloudLeft                    $cloudRight" -ForegroundColor Blue
                Write-Host "             $airplane" -ForegroundColor Yellow
                Write-Host "         Loading flight data..." -ForegroundColor Green
            }
            1 { 
                Write-Host "    $cloudLeft                    $cloudRight" -ForegroundColor Blue
                Write-Host "                  $airplane" -ForegroundColor Yellow
                Write-Host "         Loading flight data..." -ForegroundColor Green
            }
            2 { 
                Write-Host "    $cloudLeft                    $cloudRight" -ForegroundColor Blue
                Write-Host "                       $airplane" -ForegroundColor Yellow
                Write-Host "         Loading flight data..." -ForegroundColor Green
            }
        }
        Start-Sleep -Milliseconds 500
    }
    Clear-Host
}

# Function to format and display flight information
function Show-FlightInfo {
    param([object]$Flight)
    
    # Show airplane header with animation
    Write-Host "`n" -ForegroundColor Green
    Write-Host "✈️ ════════════════════════════════════ ✈️" -ForegroundColor Cyan
    Write-Host "           FLIGHT INFORMATION           " -ForegroundColor Cyan
    Write-Host "✈️ ════════════════════════════════════ ✈️" -ForegroundColor Cyan
    
    # Flight Date
    $flightDate = if ($Flight.flight_date) { 
        try {
            $date = [DateTime]::Parse($Flight.flight_date)
            $date.ToString("dddd, MMMM dd, yyyy")
        } catch {
            $Flight.flight_date
        }
    } else { "Not available" }
    Write-Host "📅 Flight Date:              " -NoNewline -ForegroundColor Yellow
    Write-Host $flightDate -ForegroundColor White
    
    # Flight Status
    $status = if ($Flight.flight_status) { $Flight.flight_status } else { "Not available" }
    $statusColor = switch ($status.ToLower()) {
        "active" { "Green" }
        "scheduled" { "Yellow" }
        "landed" { "Blue" }
        "cancelled" { "Red" }
        "delayed" { "Magenta" }
        default { "White" }
    }
    $statusIcon = switch ($status.ToLower()) {
        "active" { "🟢" }
        "scheduled" { "🟡" }
        "landed" { "🔵" }
        "cancelled" { "🔴" }
        "delayed" { "🟠" }
        default { "⚪" }
    }
    Write-Host "$statusIcon Flight Status:            " -NoNewline -ForegroundColor Yellow
    Write-Host $status -ForegroundColor $statusColor
    
    # Departure Airport
    $depAirport = "Not available"
    if ($Flight.departure -and $Flight.departure.airport) {
        $depAirport = $Flight.departure.airport
    }
    Write-Host "🛫 Departure Airport:        " -NoNewline -ForegroundColor Yellow
    Write-Host $depAirport -ForegroundColor White
    
    # Arrival Airport
    $arrAirport = "Not available"
    if ($Flight.arrival -and $Flight.arrival.airport) {
        $arrAirport = $Flight.arrival.airport
    }
    Write-Host "🛬 Arrival Airport:          " -NoNewline -ForegroundColor Yellow
    Write-Host $arrAirport -ForegroundColor White
    
    # Airline Company
    $airline = "Not available"
    if ($Flight.airline -and $Flight.airline.name) {
        $airline = $Flight.airline.name
    }
    Write-Host "🏢 Airline Company:          " -NoNewline -ForegroundColor Yellow
    Write-Host $airline -ForegroundColor White
    
    # Departure Scheduled Time
    $depScheduled = "Not available"
    if ($Flight.departure -and $Flight.departure.scheduled) {
        try {
            $depTime = [DateTime]::Parse($Flight.departure.scheduled)
            $depScheduled = $depTime.ToString("MMM dd, yyyy - HH:mm") + " UTC"
        } catch {
            $depScheduled = $Flight.departure.scheduled
        }
    }
    Write-Host "⏰ Departure Scheduled:      " -NoNewline -ForegroundColor Yellow
    Write-Host $depScheduled -ForegroundColor White
    
    # Departure Actual Time
    $depActual = "Not available"
    if ($Flight.departure -and $Flight.departure.actual) {
        try {
            $depActualTime = [DateTime]::Parse($Flight.departure.actual)
            $depActual = $depActualTime.ToString("MMM dd, yyyy - HH:mm") + " UTC"
        } catch {
            $depActual = $Flight.departure.actual
        }
    }
    Write-Host "✅ Departure Actual:         " -NoNewline -ForegroundColor Yellow
    Write-Host $depActual -ForegroundColor White
    
    # Arrival Scheduled Time
    $arrScheduled = "Not available"
    if ($Flight.arrival -and $Flight.arrival.scheduled) {
        try {
            $arrTime = [DateTime]::Parse($Flight.arrival.scheduled)
            $arrScheduled = $arrTime.ToString("MMM dd, yyyy - HH:mm") + " UTC"
        } catch {
            $arrScheduled = $Flight.arrival.scheduled
        }
    }
    Write-Host "⏰ Arrival Scheduled:        " -NoNewline -ForegroundColor Yellow
    Write-Host $arrScheduled -ForegroundColor White
    
    # Arrival Estimated Time
    $arrEstimated = "Not available"
    if ($Flight.arrival -and $Flight.arrival.estimated) {
        try {
            $arrEstTime = [DateTime]::Parse($Flight.arrival.estimated)
            $arrEstimated = $arrEstTime.ToString("MMM dd, yyyy - HH:mm") + " UTC"
        } catch {
            $arrEstimated = $Flight.arrival.estimated
        }
    }
    Write-Host "📍 Arrival Estimated:        " -NoNewline -ForegroundColor Yellow
    Write-Host $arrEstimated -ForegroundColor White
    
    Write-Host "✈️ ════════════════════════════════════ ✈️" -ForegroundColor Cyan
}

# Function to search flight by IATA code
function Search-Flight {
    param(
        [string]$ApiKey,
        [string]$FlightIATA
    )
    
    try {
        # Construct the API URL
        $url = "$ApiBaseUrl" + "?access_key=$ApiKey&flight_iata=$FlightIATA"
        
        Write-Host "Searching for flight: $FlightIATA..." -ForegroundColor Green
        
        # Show airplane animation while loading
        Show-AirplaneAnimation
        
        # Make API request
        $response = Invoke-RestMethod -Uri $url -Method Get -ContentType "application/json"
        
        # Check if response contains data
        if ($response.data -and $response.data.Count -gt 0) {
            Write-Host "✅ Found $($response.data.Count) flight(s)" -ForegroundColor Green
            
            # Display each flight
            foreach ($flight in $response.data) {
                Show-FlightInfo -Flight $flight
            }
        }
        else {
            Write-Host "❌ No flights found with IATA code: $FlightIATA" -ForegroundColor Red
            
            # Check for API errors
            if ($response.error) {
                Write-Host "⚠️ API Error: $($response.error.message)" -ForegroundColor Red
            }
        }
    }
    catch {
        Write-Error "❌ Error occurred while searching for flight: $($_.Exception.Message)"
        
        # Check if it's an HTTP error
        if ($_.Exception.Response) {
            $statusCode = $_.Exception.Response.StatusCode.value__
            Write-Host "🔴 HTTP Status Code: $statusCode" -ForegroundColor Red
            
            switch ($statusCode) {
                401 { Write-Host "🔐 Authentication failed. Please check your API key." -ForegroundColor Red }
                403 { Write-Host "🚫 Access forbidden. Your API plan might not support this feature." -ForegroundColor Red }
                429 { Write-Host "⏱️ Rate limit exceeded. Please try again later." -ForegroundColor Red }
                default { Write-Host "❌ HTTP error occurred." -ForegroundColor Red }
            }
        }
    }
}

# Main script execution
function Main {
    Write-Host "✈️ ═══════════════════════════════════════ ✈️" -ForegroundColor Cyan
    Write-Host "        🌟 FLIGHT TRACKER SCRIPT 🌟          " -ForegroundColor Cyan
    Write-Host "✈️ ═══════════════════════════════════════ ✈️" -ForegroundColor Cyan
    Write-Host ""
    
    # Get API key
    $apiKey = Get-ApiKey -ProvidedKey $ApiKey
    
    # Get flight code if not provided
    if ([string]::IsNullOrEmpty($FlightCode)) {
        $FlightCode = Read-Host "✈️ Enter flight IATA code (e.g., AZ123)"
    }
    
    if ([string]::IsNullOrEmpty($FlightCode)) {
        Write-Error "❌ Flight IATA code is required."
        exit 1
    }
    
    # Search for the flight
    Search-Flight -ApiKey $apiKey -FlightIATA $FlightCode
    
    Write-Host "`n🎯 Press any key to exit..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Run the main function if script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Main
}