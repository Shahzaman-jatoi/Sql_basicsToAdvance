USE DATA_CLEANING
SELECT * FROM dbo.Nashville_housing;

-- LETS CLEAN THE NULL VALUES ON BEHALF OF THE PARCELID
SELECT a.UniqueID, a.ParcelID, a.PropertyAddress,b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress) AS PropertyAddressUpdated
FROM dbo.Nashville_housing AS a
JOIN dbo.Nashville_housing AS b
    ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
-- WHERE a.PropertyAddress is NULL OR b.PropertyAddress IS NULL

UPDATE a
SET a.PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress) 
FROM dbo.Nashville_housing AS a
JOIN dbo.Nashville_housing AS b
    ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID

-- SELECT PropertyAddress
-- FROM dbo.Nashville_housing  
-- WHERE PropertyAddress is null  // running this query to check if the nulls have been updated

-- MODIFY PROPERTY ADDRESS USING SUBSTRING 

SELECT PropertyAddress,
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1),
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))
FROM dbo.Nashville_housing

ALTER TABLE Nashville_housing
ADD Property_Address NVARCHAR(255);

UPDATE Nashville_housing
SET Property_Address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

ALTER TABLE Nashville_housing
ADD cityName NVARCHAR(255);

UPDATE Nashville_housing
SET cityName = LTRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)));

-- CHANGE OWNER'S ADDRESS USING PARSENAME 

SELECT OwnerAddress, 
TRIM(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)),
TRIM(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)),
TRIM(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1))
FROM dbo.Nashville_housing

ALTER TABLE Nashville_housing
ADD Owner_Address NVARCHAR(255)

UPDATE Nashville_housing
SET Owner_Address = TRIM(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3))

ALTER TABLE Nashville_housing
ADD OwnerCity NVARCHAR(255)

UPDATE Nashville_housing
SET OwnerCity = TRIM(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2))

ALTER TABLE Nashville_housing
ADD OwnerState NVARCHAR(255)

UPDATE Nashville_housing
SET OwnerState = TRIM(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1))

SELECT Owner_Address, OwnerCity, OwnerState
FROM dbo.Nashville_housing

-- CHANGE Y/N TO YES/NO 

SELECT
    CASE 
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
        END
FROM dbo.Nashville_housing


UPDATE Nashville_housing
SET SoldAsVacant =
    CASE 
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
        END

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM Nashville_housing
GROUP BY SoldAsVacant

SELECT *
FROM Nashville_housing
-- REMOVING DUPLICATES
GO
WITH CTE_rowNum AS(
SELECT *, ROW_NUMBER() OVER(PARTITION BY 
    PARCELID,
    Property_Address,
    SaleDate,
    SalePrice,
    LegalReference
    ORDER BY UniqueID
    ) AS num
FROM Nashville_housing 
)
SELECT *
FROM CTE_rowNum
WHERE num > 1

-- DELETE UNNECESSARY COLUMN

ALTER TABLE Nashville_housing
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict 

-- RENAMING A COLUMN ACERAGE TO AVERAGE

EXEC sp_rename 'Nashville_housing.Acreage', 'Average', 'COLUMN'