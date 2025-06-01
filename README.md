# ✈️ Flight Tracker PowerShell Script

A modern, animated PowerShell script that uses the AvionStack API to track and display flight information by IATA code with beautiful UI enhancements.

## 🌟 Features

- **🔍 Flight Search**: Search flights by IATA code (e.g., AZ123)
- **🎬 Animated UI**: Beautiful airplane animation while loading flight data
- **📊 Comprehensive Information**: Display detailed flight information including:
  - 📅 Flight Date (formatted as "Friday, June 01, 2025")
  - 🟢🟡🔵🔴🟠 Flight Status (with color-coded emoji indicators)
  - 🛫 Departure Airport
  - 🛬 Arrival Airport
  - 🏢 Airline Company
  - ⏰ Departure Scheduled Time (formatted as "Jun 01, 2025 - 14:30 UTC")
  - ✅ Departure Actual Time
  - ⏰ Arrival Scheduled Time
  - 📍 Arrival Estimated Time
- **🎨 Enhanced UI**: Modern interface with emojis, animations, and improved formatting
- **⚡ Real-time Feedback**: Visual loading indicators and status updates

## 🚀 Prerequisites

1. **AvionStack API Key**: You need to sign up at [AvionStack](https://aviationstack.com/) to get a free API key
2. **PowerShell**: The script works with both Windows PowerShell and PowerShell Core
3. **Unicode Support**: Ensure your terminal supports Unicode characters for proper emoji display

## 📋 Setup

### Option 1: Set Environment Variable (Recommended)
Set your API key as an environment variable:

```powershell
$env:AVIATIONSTACK_API_KEY = "your_api_key_here"
```

To make it permanent, add it to your PowerShell profile or system environment variables.

### Option 2: Pass API Key as Parameter
You can provide the API key when running the script.

## 🎮 Usage

### Interactive Mode
Run the script and it will prompt for the API key (if not set) and flight code:

```powershell
.\FlightsTracker.ps1
```

### With Parameters
Provide the API key and/or flight code as parameters:

```powershell
# With API key and flight code
.\FlightsTracker.ps1 -ApiKey "your_api_key" -FlightCode "AZ123"

# With flight code only (uses environment variable for API key)
.\FlightsTracker.ps1 -FlightCode "AZ123"

# With API key only (prompts for flight code)
.\FlightsTracker.ps1 -ApiKey "your_api_key"
```

## 🎬 Animation Features

The script includes several visual enhancements:

- **✈️ Airplane Animation**: Moving airplane with clouds during data loading
- **🎨 Emoji Icons**: Each piece of information has a relevant emoji for quick identification
- **🌈 Color-Coded Status**: Flight status displayed with appropriate colors and emoji indicators
- **📏 Formatted Borders**: Beautiful airplane-themed borders and headers

## 📱 Example Output

```
✈️ ═══════════════════════════════════════ ✈️
        🌟 FLIGHT TRACKER SCRIPT 🌟          
✈️ ═══════════════════════════════════════ ✈️

✈️ Enter flight IATA code (e.g., AZ123): AZ123

    ☁️                    ☁️
             ✈️
         Loading flight data...

✅ Found 1 flight(s)

✈️ ════════════════════════════════════ ✈️
           FLIGHT INFORMATION           
✈️ ════════════════════════════════════ ✈️
📅 Flight Date:              Friday, June 01, 2025
🟢 Flight Status:            active
🛫 Departure Airport:        John F. Kennedy International Airport
🛬 Arrival Airport:          Leonardo da Vinci International Airport
🏢 Airline Company:          Alitalia
⏰ Departure Scheduled:      Jun 01, 2025 - 14:30 UTC
✅ Departure Actual:         Jun 01, 2025 - 14:35 UTC
⏰ Arrival Scheduled:        Jun 02, 2025 - 06:45 UTC
📍 Arrival Estimated:        Jun 02, 2025 - 06:50 UTC
✈️ ════════════════════════════════════ ✈️

🎯 Press any key to exit...
```

## 🎨 Flight Status Indicators

The script displays flight status with both colors and emoji indicators:

- **🟢 Green**: Active flights
- **🟡 Yellow**: Scheduled flights
- **🔵 Blue**: Landed flights
- **🔴 Red**: Cancelled flights
- **🟠 Orange**: Delayed flights
- **⚪ White**: Other statuses

## ⚠️ Error Handling

The script includes comprehensive error handling with enhanced visual feedback:

- **🔐 Invalid API keys** (401 Unauthorized): Authentication failed message
- **🚫 Access restrictions** (403 Forbidden): Plan limitation warnings
- **⏱️ Rate limiting** (429 Too Many Requests): Rate limit exceeded notifications
- **❌ Network connectivity issues**: Connection error handling
- **⚠️ Invalid flight codes**: Flight not found messages

All error messages include relevant emojis for better visual identification.

## 🎯 Enhanced Features

### Date and Time Formatting
- **Flight Date**: Displays as "Friday, June 01, 2025" instead of raw API format
- **All Times**: Formatted as "Jun 01, 2025 - 14:30 UTC" for better readability
- **Timezone Clarity**: All times clearly marked as UTC

### Visual Improvements
- **🎬 Loading Animation**: Animated airplane moves across the screen while fetching data
- **📱 Modern UI**: Clean, emoji-rich interface with consistent spacing
- **🌈 Color Coding**: Intuitive color scheme throughout the application
- **📏 Professional Layout**: Well-structured information display

## 📊 API Limitations

- Free tier has limited requests per month
- Some features may require a paid plan
- Real-time data availability depends on the airline and airport

## 🔧 Troubleshooting

1. **🔐 "Authentication failed"**: Check your API key is correct
2. **❌ "No flights found"**: Verify the IATA code is correct and the flight exists
3. **⏱️ "Rate limit exceeded"**: Wait before making another request (free tier limitations)
4. **🌐 Network errors**: Check your internet connection
5. **👁️ Emoji display issues**: Ensure your terminal supports Unicode characters
6. **🎨 Color display problems**: Use a modern terminal that supports ANSI colors

## 🚀 Requirements

- **PowerShell 5.1+** or **PowerShell Core 6.0+**
- **Internet connection** for API access
- **Terminal with Unicode support** for proper emoji display
- **AvionStack API key** (free tier available)

## 📄 License

This script is provided as-is for educational and personal use.
