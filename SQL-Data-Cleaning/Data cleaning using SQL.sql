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

-- Fixing data into a standard format

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoff_staging2;
# %m is not same as %M. m gives 2 digit month date, whereas M gives full name of the month
# write in the above format to get the date in correct format in - way

update layoff_staging2
set date= str_to_date(`date`, '%m/%d/%Y');

select *
from layoff_staging2;
-- changing into date column
-- dont do alter on your raw data ever

ALTER TABLE layoff_staging2
Modify column `date` DATE ;

-- Fixing NULL values 

 select *
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

select count(*)
from layoff_staging2
where total_laid_off is null and percentage_laid_off is null;
-- will fix this later

-- Deleting rows and columns that are not necessary
select *
from layoff_staging2
where industry is null
or industry= ""  
;

update layoff_staging2
set industry =NULL
WHERE industry="";

 select *
 from layoff_staging2
where company like "airbnb";

select t1.industry, t2.industry
from layoff_staging2 t1
join layoff_staging2 t2
	on t1.company = t2.company
where (t1.industry  is null or t1.industry ="")   	
and t2.industry is not null;
 
 update layoff_staging2 t1
 join layoff_staging2 t2
	on t1.company=t2.company
set t1.industry = t2.industry
where t1.industry  is null 
and t2.industry is not null;

 # what happened here is we made the blank space into NULL values
 # and then we updated the layoff_staging2 by doing self join on the basis of company
 # and then updated the value of of not null into null
 
 select *
 from layoff_staging2
where company like "bally%";

  
select *
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete 
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoff_staging2;

# drop a column
alter table layoff_staging2
drop column row_num;

select *
from layoff_staging2
limit 20;


