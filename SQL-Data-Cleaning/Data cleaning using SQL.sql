-- Data Cleaning

select *
from layoffs;

create table layoff_staging
like layoffs;

select *
from layoff_staging;

insert layoff_staging
select *
from layoffs;

select *,
row_number() Over(
Partition by company, industry, total_laid_off, percentage_laid_off,`date`) as row_num 
from layoff_staging;

# having row_num greater than or equal to 2 means there is duplicacy

with duplicate_cte as
(
	select *,
	row_number() Over(
	Partition by company,location, industry, total_laid_off, percentage_laid_off,`date`,stage,
    country,funds_raised_millions) as row_num 
	from layoff_staging
)
delete 
from duplicate_cte
where row_num >1;
# we cannot directly delete
# what we can do is we an create a layoff_staging 2 and delete the row num
# there wherever we have row_num >2 
# creating a table with an extra row and then deleting that row_num has 2


CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoff_staging2
where row_num>1;

insert into layoff_staging2
	select *,
	row_number() Over(
	Partition by company,location, industry, total_laid_off, percentage_laid_off,`date`,stage,
    country,funds_raised_millions) as row_num 
	from layoff_staging;

select *
from layoff_staging2;

DELETE 
from layoff_staging2
where row_num>1;

select *
from layoff_staging2;

Select count(*) from layoff_staging2;
# WE removed Duplicates

-- Standardizing data (finding issue and fixing it such as spelling, spacing etc)

select company, TRIM(company)
from layoff_staging2;

# Now we have to update the trim in our original data

UPDATE layoff_staging2
set company = TRIM(company); 

select *
from layoff_staging2
where industry Like "crypto%";

update layoff_staging2
set industry="Crypto"
where industry like "crypto%";

select DISTINCT COUNTRY,trim(TRAILING "." FROM country)
from layoff_staging2
order by 1;
# trailing means whatever coming at the end. In this case we need to trim "." from country

update layoff_staging2
set country = trim(TRAILING "." FROM country)
where country like "United states%";

select 


