
USE project;

SELECT *
FROM project.org_nashville_housing;

SELECT COUNT(UniqueID) # 56477
FROM project.org_nashville_housing;

ALTER TABLE project.org_nashville_housing
DROP COLUMN MyUnknownColumn;

COMMIT;

-- Change SaleData to mm dd yyyy format

SELECT 
	SaleDate,
	STR_TO_DATE(SaleDate, '%M %d, %Y')
FROM 
	project.org_nashville_housing
LIMIT 5;

-- Populate PropertyAddess data

-- 29 rows 
SELECT
	PropertyAddress
FROM
	project.org_nashville_housing
WHERE PropertyAddress IS NULL;

SELECT
	o1.UniqueID,
    o1.ParcelID,
    o1.PropertyAddress,
    o2.PropertyAddress,
    IFNULL(o1.PropertyAddress, o2.PropertyAddress)
FROM
	org_nashville_housing o1, org_nashville_housing o2
WHERE o1.ParcelID = o2.ParcelID 
    AND o1.UniqueID <> o2.UniqueID
    AND o1.PropertyAddress IS NULL
GROUP BY 1
ORDER BY 1; -- With GROUP BY 29 rows, without GROUP BY 35 rows. 

SELECT
	UniqueID AS 'Unique ID',
    ParcelID,
    PropertyAddress,
    '1' AS Type
FROM
	project.org_nashville_housing
WHERE PropertyAddress IS NULL
UNION
SELECT
	o1.UniqueID,
    o1.ParcelID,
    o1.PropertyAddress,
    '2' AS Type
FROM
	org_nashville_housing o1, org_nashville_housing o2
WHERE o1.ParcelID = o2.ParcelID
	-- o1.ParcelID = o2.ParcelID 
    AND o1.UniqueID <> o2.UniqueID
    AND o1.PropertyAddress IS NULL
GROUP BY 1
ORDER BY 1; -- With GROUP BY 58, wihout 59

COMMIT;

UPDATE org_nashville_housing A
INNER JOIN
	org_nashville_housing B ON A.ParcelID = B.ParcelID
SET
	A.PropertyAddress = B.PropertyAddress
WHERE
	A.UniqueID <> B.UniqueID
    AND A.PropertyAddress IS NULL; -- 29 rows affected

SELECT 
    *
FROM
    project.org_nashville_housing
WHERE
    PropertyAddress IS NULL; # 0 row

-- Breaking out PropertyAddress into Individual Columns (Address, City)
-- 		1808 FOX CHASE DR, GOODLETTSVILLE
-- 		Address     		 City 			 
-- 		1808 FOX CHASE DR	 GOODLETTSVILLE

SELECT *
FROM org_nashville_housing
LIMIT 15;

SELECT
	PropertyAddress,
    TRIM(SUBSTR(PropertyAddress, 1, LOCATE(',', PropertyAddress)-1)) AS Address,
    TRIM(SUBSTR(PropertyAddress, POSITION(',' IN PropertyAddress)+1)) AS City,
    POSITION(',' IN PropertyAddress),
    LOCATE(',', PropertyAddress)
FROM org_nashville_housing;

-- Add two columns called ProprtySplitAddress and PropertySplitCity

COMMIT;

ALTER TABLE project.org_nashville_housing
ADD COLUMN PropertySplitAddress VARCHAR(255);

ALTER TABLE project.org_nashville_housing
ADD COLUMN PropertySplitCity VARCHAR(255);

SELECT 
    *
FROM
    project.org_nashville_housing;

UPDATE project.org_nashville_housing
SET PropertySplitAddress = TRIM(SUBSTR(PropertyAddress, 1, LOCATE(',', PropertyAddress)-1));

UPDATE project.org_nashville_housing
SET PropertySplitCity = TRIM(SUBSTR(PropertyAddress, LOCATE(',', PropertyAddress)+1));



-- Breaking out OwnerAddress into Individual Columns (Address, City, State)
-- 		1808 FOX CHASE DR, GOODLETTSVILLE
-- 		Address     		 City 			 
-- 		1808 FOX CHASE DR	 GOODLETTSVILLE

SELECT 
	*
FROM
	org_nashville_housing;

SELECT 
    A.UniqueID,
    A.ParcelID,
    A.OwnerAddress,
    A.PropertyAddress,
    B.OwnerAddress,
    B.PropertyAddress,
    CONCAT(IFNULL(A.OwnerAddress, A.PropertyAddress), ', TN')
FROM
    org_nashville_housing A,
    org_nashville_housing B
WHERE
    A.UniqueID <> B.UniqueID
        AND A.ParcelID = B.ParcelID
        AND A.OwnerAddress IS NULL
        AND A.PropertyAddress = B.PropertyAddress;
--         AND A.TaxDistrict = B.TaxDistrict;

SELECT 
    OwnerAddress,
    TRIM(SUBSTRING_INDEX(OwnerAddress, ',', 1)) AS Address,
    TRIM(REPLACE(REPLACE(SUBSTR(OwnerAddress,
                    LOCATE(',', OwnerAddress) + 1),
                SUBSTRING_INDEX(OwnerAddress, ',', - 1),
                ''),
            ',',
            '')) AS City,
    TRIM(SUBSTRING_INDEX(OwnerAddress, ',', - 1)) AS State
FROM
    project.org_nashville_housing;

ALTER TABLE project.org_nashville_housing
ADD COLUMN OwnerSplitAddress VARCHAR(255);

ALTER TABLE project.org_nashville_housing
ADD COLUMN OwnerSplitCity VARCHAR(255);

ALTER TABLE project.org_nashville_housing
ADD COLUMN OwnerSplitState VARCHAR(255);


UPDATE project.org_nashville_housing
SET OwnerSplitAddress = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', 1));

UPDATE project.org_nashville_housing
SET OwnerSplitCity = TRIM(REPLACE(REPLACE(SUBSTR(OwnerAddress,
										LOCATE(',', OwnerAddress) + 1),
									SUBSTRING_INDEX(OwnerAddress, ',', - 1),
									''),
								',',
								''));

UPDATE project.org_nashville_housing
SET OwnerSplitState = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', - 1));


