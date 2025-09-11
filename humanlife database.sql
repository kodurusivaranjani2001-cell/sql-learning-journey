create database if not exists humanlife;
use humanlife;
create table god (
    god_id int auto_increment primary key,
    name varchar(25),
    power varchar(25));

create table humanworry (
    worry_id int auto_increment primary key,
    description varchar(25),
    gods_id int,
    foreign key (gods_id) references god(god_id));

create table dreams (
    dm_id int auto_increment primary key,
    deadline date,
    hardwork int);

create table work (
    work_id int auto_increment primary key,
    passion varchar(25),
    working_hours varchar(20),
    dm_id int,
    foreign key (dm_id) references dreams(dm_id));

create table happiness (
    happines_id int auto_increment primary key,
    reason varchar(55),
    celebration varchar(50),
    dream_id int,
    foreign key (dream_id) references dreams(dm_id));

create table wealth (
    wealth_id int auto_increment primary key,
    wealth_status varchar(25),
    happines_id int,
    foreign key (happines_id) references happiness(happines_id));

create table health (
    health_id int auto_increment primary key,
    food varchar(25),
    exercise varchar(25),
    work_id int,
    wealth_id int,
    foreign key (work_id) references work(work_id),
    foreign key (wealth_id) references wealth(wealth_id));

insert into god (name, power) values 
('ganesha','wealth'),
('shiva','high energy'),
('parvathi','sakthi'),
('hanuman','dare'),
('krishna','love');

insert into humanworry (description, gods_id) values
('money problem',1),
('fear',4),
('job',3),
('stress',2),
('health',4);

insert into dreams (deadline, hardwork) values
('2025-08-12',6),
('2025-08-05',7),
('2025-08-27',8);

insert into work (passion, working_hours, dm_id) values
('professor','5 hrs',1),
('artist','6 hrs',2),
('business man','8 hrs',3);

-- happiness
insert into happiness (reason, celebration, dream_id) values
('distinction pass','sweets',1),
('job','party',2),
('promotion','party',3);

insert into wealth (wealth_status, happines_id) values
('rich',1),
('middle class',2),
('millionaire',3);

insert into health (food, exercise, work_id, wealth_id) values
('biryani','6 hrs',1,1),
('diet food','2 hrs',2,2),
('measured food','1 hr',3,3);

use humanlife;

select g.name as god, g.power, hw.description as worry
from god g
left join humanworry hw
on g.god_id = hw.gods_id;

select w.passion, w.working_hours, d.deadline, d.hardwork
from work w
inner join dreams d
on w.dm_id = d.dm_id;

select h.food, h.exercise, wth.wealth_status
from health h
left join wealth wth
on h.wealth_id = wth.wealth_id;

select wth.wealth_status, hp.reason as happiness_reason
from wealth wth
left join happiness hp
on wth.happines_id = hp.happines_id;

select g.name as god, count(hw.worry_id) as total_worries
from god g
left join humanworry hw
on g.god_id = hw.gods_id
group by g.god_id;

select w.passion, w.working_hours, d.deadline, d.hardwork, h.food, h.exercise
from work w
join dreams d on w.dm_id = d.dm_id
left join health h on h.work_id = w.work_id;


update god
set power = 'mother of universe'
where god_id = 3;









