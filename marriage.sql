use marriage;
create table Grooms( Groom_id int primary key auto_increment,
FullName varchar(100) not null,
Age int check (age >= 18),
Education varchar (100),
Occupation varchar(100),
Income decimal(12,2),
City  varchar(50),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
create table Brides( Bride_id int primary key auto_increment,
FullName varchar(100) not null,
Age int check (age >= 18),
Education varchar (100),
Occupation varchar(100),
Income decimal(12,2),
City  varchar(50),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);
create table marriage (
marriage_id int primary key auto_increment,
Groom_id int not null,
Bride_id int not null,
MarriageDate DATE ,
Venue varchar(200),

Status ENUM ('planned','completed','cancelled') default 'planned',
foreign key (Groom_id) references Grooms(Groom_id),
foreign key (Bride_id) references Brides(Bride_id)
);

create index idx_groom_city on Grooms(City);
create index idx_marriage_groom_bride on marriage(Groom_id,Bride_id);
create index idx_bride_edu_city on Brides(Education,City); 

insert into Brides (Fullname ,Age,Education,Occupation,Income,City) values
('gita',29,'mba','hr',509876,'bangalore'),
('gouri',35,'btech','it',60000,'hyderabad'),
('sita',26,'degree','bed',30000,'native');

insert into Grooms (Fullname ,Age,Education,Occupation,Income,City) values
('ram',29,'mba','hr',40000,'bangalore'),
('raghu',35,'btech','it',60000,'hyderabad'),
('srinu',26,'degree','bed',30000,'native');

insert into marriage (Groom_id, Bride_id, MarriageDate, Venue)
values
(1, 3, '2025-09-01', 'Chennai'),
(2, 2, '2025-10-12', 'Hyderabad'),
(3, 1, '2025-12-25', 'Bangalore');


#show index from grooms
-- groping and aggregation


select city , min(age) as smallest_bride, avg(age) as average_age
from brides
group by city
order by smallest_bride;

select education 
from brides
group by education;

use marriage;
with high_earning_groom as (
select distinct  g.fullname,g.age,g.income
from grooms g
join marriage m  on g.groom_id= m.groom_id
where m.status='planned'
)
select * from high_earning_groom
order by income desc;
-- totall marriages per city
select g.city ,count(*) as marriges_count
from marriage m
join grooms g 
on g.groom_id=m.groom_id
group by city;

-- windows  function
select bride_id,fullname,age,city,income,
	rank() over ( order by income desc )AS rankin_city
    from brides;
-- subquery example
select fullname ,education,income
from brides 
where income > (select min(income) from brides );

use marriage ;
select 'groom' as role, avg(age) as avgage from grooms;
select occupation , count(*) as count from grooms
group by occupation
order by count desc;

select MONTH(MarriageDate) as month ,COUNT(*) as totallmarriages
from marriage
where status='planned'
group by month(MarriageDate)
order by month;
# INCOME DISTRIBUTION (BUCKETED EXAMPLE
select 
	case
		when income >20000 then '>20k'
		when income between 300000 and 700000 then '30k - 70k'
		else '>70k'
	end as incomerange,
	count(*)  as count
from grooms
group by incomerange;
# matching analysys
-- city combinations of married couples
select 
	g.city as groomcity,
	b.city as bridecity,
	count(*) as count
from marriage m
join grooms g on m.groom_id=g.groom_id
join brides b on m.bride_id=b.bride_id
group by g.city,b.city
order by count desc;
-- income comparison
select 
	g.fullname as groom,
    b.fullname as bride,
    g.income as groomincome,
    b.income as brideincome,
    (g.income-b.income) as income_difference
 from marriage m
 join grooms g on m.groom_id=g.groom_id
 join brides b on m.bride_id=b.bride_id;
-- number of marriages per year
select YEAR(marriagedate) as year ,count(*) as totalmarriages
from marriage 
where status='planned'
group by YEAR(marriagedate)
order by year;
-- time from registration to marriage
select 
	m.marriage_id ,
    g.fullname as groom,
    b.fullname as bride,
    datediff(marriagedate,g.createdat) as datsfromregistrationtomarriage
from marriage m
join grooms g on m.marriage_id=g.groom_id
join brides b on m.marriage_id=b.bride_id;

    
    

    
    
    
    
    






