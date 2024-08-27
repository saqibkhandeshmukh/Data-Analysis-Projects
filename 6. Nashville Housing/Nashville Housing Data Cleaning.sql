--- create database ---
	create database "nashville housing data cleaning"

--- create table nashville_housing ---
	create table nashville_housing
	(
	UniqueID int8,
	ParcelID varchar(200),
	LandUse varchar(200),
	PropertyAddress varchar(200),
	SaleDate date,
	SalePrice int8,
	LegalReference varchar(200),
	SoldAsVacant varchar(200),
	OwnerName varchar(200),
	OwnerAddress varchar(200),
	Acreage numeric,
	TaxDistrict varchar(200),
	LandValue int8,
	BuildingValue int8,
	TotalValue int8,
	YearBuilt int8,
	Bedrooms int8,
	FullBath int8,
	HalfBath int8
	)
	
--- data import ---
	copy nashville_housing (UniqueID, ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, LegalReference, SoldAsVacant,
							OwnerName, OwnerAddress, Acreage, TaxDistrict, LandValue, BuildingValue, TotalValue, YearBuilt,
							Bedrooms, FullBath, HalfBath)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\6. Nashville Housing\nashville_housing_data.csv'
	delimiter ','
	csv header

--- size and details of data ---
	select * from nashville_housing
	select count(*) as rows from nashville_housing
	select count(*) as column from information_schema.columns where table_name = 'nashville_housing'
	select column_name, data_type from information_schema.columns where table_name = 'nashville_housing'
	
--- data cleaning ---
	-- standardize date format
	select saledate
	from nashville_housing
	
	-- populate property address area
	select *
	from nashville_housing
	where propertyaddress is null
	order by parcelid

	--
	select
		a.parcelid,
		a.propertyaddress,
		b.parcelid,
		b.propertyaddress,
		coalesce(a.propertyaddress, b.propertyaddress)
	from nashville_housing as a
	join nashville_housing as b
		on a.parcelid = b.parcelid
		and a.uniqueid <> b.uniqueid
	where a.propertyaddress is null

	--
	update nashville_housing a
	set propertyaddress = coalesce(a.propertyaddress, b.propertyaddress)
	from nashville_housing b
	where a.parcelid = b.parcelid
		and a.uniqueid <> b.uniqueid 
		and a.propertyaddress is null
	
	-- breaking out property address into individual columns (address, city, state)
	select propertyaddress
	from nashville_housing

	--
	select
    	substring(propertyaddress from 1 for position(',' in propertyaddress) - 1) as address,
    	substring(propertyaddress from position(',' in propertyaddress) + 1) as address
	from nashville_housing;

	--
	alter table nashville_housing
	add propertysplitaddress varchar(255)

	--
	update nashville_housing
	set propertysplitaddress = substring(propertyaddress from 1 for position(',' in propertyaddress) - 1)

	--
	alter table nashville_housing
	add propertysplitcity varchar(255)

	--
	update nashville_housing
	set propertysplitcity = substring(propertyaddress from position(',' in propertyaddress) + 1)
										
	-- breaking out owner address into individual columns (address, city, state)
	select owneraddress
	from nashville_housing

	--
	select 
		split_part (owneraddress, ',', 1) as address,
		split_part (owneraddress, ',', 2) as city,
		split_part (owneraddress, ',', 3) as state
	from nashville_housing

	--
	alter table nashville_housing
	add ownersplitaddress varchar(255)

	--
	update nashville_housing
	set ownersplitaddress = split_part (owneraddress, ',', 1)

	--
	alter table nashville_housing
	add ownersplitcity varchar(255)

	--
	update nashville_housing
	set ownersplitcity = split_part (owneraddress, ',', 2)

	--
	alter table nashville_housing
	add ownersplitstate varchar(255)

	--
	update nashville_housing
	set ownersplitstate = split_part (owneraddress, ',', 3)
	
	-- change Y and N to Yes and No in sold as vacant field
	select
		distinct soldasvacant,
		count(soldasvacant)
	from nashville_housing
	group by soldasvacant
	order by 2

	--
	select
		soldasvacant,
		case
		when soldasvacant = 'Y' then 'Yes'
		when soldasvacant = 'N' then 'No'
		else soldasvacant
		end
	from nashville_housing

	--
	update nashville_housing
	set soldasvacant = case
		when soldasvacant = 'Y' then 'Yes'
		when soldasvacant = 'N' then 'No'
		else soldasvacant
		end
		
	-- identify duplicates
	with row_num_cte as(
		select *,
			-- parcelid,
		row_number () over (
		partition by parcelid,
				propertyaddress,
				saleprice,
				saledate,
				legalreference
		order by uniqueid) as row_num
		from nashville_housing
		-- order by parcelid
	)
	select *
	from row_num_cte
	where row_num > 1
	-- order by propertyaddress

	-- deleting duplicates
	with row_num_cte as (
    	select
			ctid, -- This is a special PostgreSQL column that can be used to uniquely identify rows
	row_number() over (
    partition by parcelid,
				propertyaddress,
                saleprice,
                saledate,
                legalreference
    order by uniqueid) as row_num
    from nashville_housing
	)
	delete
	from nashville_housing
	using row_num_cte
	where nashville_housing.ctid = row_num_cte.ctid
  		and row_num_cte.row_num > 1

	-- delete unused columns
	alter table nashville_housing
	drop column owneraddress,
	drop column taxdistrict,
	drop column propertyaddress
	
--- size and details of data post data cleaning ---
	select * from nashville_housing
	select count(*) as rows from nashville_housing
	select count(*) as column from information_schema.columns where table_name = 'nashville_housing'
	select column_name, data_type from information_schema.columns where table_name = 'nashville_housing'