USE NOAAWeather
-- Create Historic Table

CREATE TABLE dbo.Stations
(
	ID	VARCHAR(200) NOT NULL PRIMARY KEY,
	Name	VARCHAR(200),
	Elevation	DECIMAL(10,4),
	ElevationUnit	VARCHAR(100),
	DataCoverage	DECIMAL(18,4),
	MinDate	DATE,
	MaxDate	DATE,
	Latitude	DECIMAL(18,10),
	Longitude	DECIMAL(18,10)
)

INSERT INTO Stations
(
	ID,	
	Name,
	Elevation,	
	ElevationUnit,
	DataCoverage,	
	MinDate,
	MaxDate,
	Latitude,
	Longitude
)

SELECT 
	ID,	
	Name,
	Elevation,	
	ElevationUnit,
	DataCoverage,	
	MinDate,
	MaxDate,
	Latitude,
	Longitude
FROM Staging_Stations_Results
--(1000 rows affected)

update Staging_Stations_Results
set elevation = NULL
where elevation = ''
-- (7 rows affected)

-- Create View for PowerBI

CREATE OR ALTER VIEW  dbo.vw_NOAAStations
AS
SELECT ID,	
	Name,
	CASE WHEN CHARINDEX(',', [Name]) > 0 then RIGHT([Name], 2) ELSE NULL END AS [Country],
	Elevation,	
	ElevationUnit,
	DataCoverage,	
	MinDate,
	MaxDate,
	Latitude,
	Longitude FROM Stations