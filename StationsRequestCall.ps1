#path to the text file containing the token
$tokenFilePath = "C:\Users\wisdo\OneDrive\Work documents\noaa_token.txt"

#read token from textfile
$token = Get-Content -Path $tokenFilePath

#declare start date to search
$StartDate = "2025-01-01"

#declare record page limit
$RecordLimit = 1000

#declare offset
$RecordOffset = 1

#Define API Endpoint and headers

$uri = "https://www.ncei.noaa.gov/cdo-web/api/v2/stations?limit=" + $RecordLimit + "&offset=" + $RecordOffset + "&startdate=" + $StartDate	
$headers = @{
    'Content-Type' = 'application/json'
    'token' = "$token"
    'Accept' = 'application/json'
}

#make API call and retrive data

$response = Invoke-RestMethod -Uri $uri -Method GET -Headers $headers

#Print response (All)

#$response

#print results
$ResponseResults = $response.results

$resultsFilePath = "C:\Users\wisdo\OneDrive\Data Analysis Projects\NOAA Project\Datasets\Stations_Results.csv"

$ResponseResults | Export-Csv `
-Path $resultsFilePath `
-NoTypeInformation `
-Delimiter "|" `
-Encoding UTF8

#USE DBA Tools Import-DBACSV to import into SQL Server

Import-DbaCsv -Path $resultsFilePath -SqlInstance DESKTOP-U6Q0RF4 -SqlCredential Get-Credential -Database NOAA_WEATHER -AutoCreateTable -Delimiter "`|"