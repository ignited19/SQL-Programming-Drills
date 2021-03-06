/*==================================================
 * Using the STATION table, acquire a list of city
 * names that DO NOT start with or end with a vowel.
 * The result list should not contain duplicates
 *================================================*/
 SELECT DISTINCT City
 FROM Station AS S WITH (NOLOCK)
 WHERE LEFT(S.City,1) NOT IN ('A','E','I','O','U')
 OR    RIGHT(S.City, 1) NOT IN ('A','E','I','O','U')

/*===================================================================
* Using fin the "Manhattan Distance" of all the
* entries within the Station table.
* 
* Manhattan Distance (MD): With as p1 =(x1, y1) and p2 = (x2, y2),
* MD = |x1 - x2| + |y1 - y2|
==================================================================*/
SELECT CAST((ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W))) AS NUMERIC(18,4))
FROM Station AS S WITH (NOLOCK)


/*=============================================
* Find the overall median value of LAT_N
* with 4 decimals places
==============================================*/
DECLARE @RowCount INT = (SELECT COUNT(*)
                         FROM Station)
                    
DECLARE @MidElement INT = CEILING(@RowCount/2)


SELECT CAST(S.LAT_N AS Decimal(10,4))
FROM Station AS S WITH (NOLOCK)
ORDER BY 1 ASC
OFFSET     @MidElement ROWS       
FETCH NEXT 1 ROWS ONLY



/*==============================================
* Acquire the months total per id
*==============================================*/
SELECT 
    id,
    MAX(CASE WHEN Month = 'Jan' THEN Revenue END) AS Jan_Revenue,
    MAX(CASE WHEN Month = 'Feb' THEN Revenue END) AS Feb_Revenue,
    MAX(CASE WHEN Month = 'Mar' THEN Revenue END) AS Mar_Revenue,
    MAX(CASE WHEN Month = 'Apr' THEN Revenue END) AS Apr_Revenue,
    MAX(CASE WHEN Month = 'May' THEN Revenue END) AS May_Revenue,
    MAX(CASE WHEN Month = 'Jun' THEN Revenue END) AS Jun_Revenue,
    MAX(CASE WHEN Month = 'Jul' THEN Revenue END) AS Jul_Revenue,
    MAX(CASE WHEN Month = 'Aug' THEN Revenue END) AS Aug_Revenue,
    MAX(CASE WHEN Month = 'Sep' THEN Revenue END) AS Sep_Revenue,
    MAX(CASE WHEN Month = 'Oct' THEN Revenue END) AS Oct_Revenue,
    MAX(CASE WHEN Month = 'Nov' THEN Revenue END) AS Nov_Revenue,
    MAX(CASE WHEN Month = 'Dec' THEN Revenue END) AS Dec_Revenue 
FROM Department
GROUP BY ID
