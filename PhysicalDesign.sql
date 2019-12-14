use group5;

create index q1 on tweets(theYear);
select * from tweets where theYear = 2016;

drop index q1 on tweets;

create index dem on user(sub_category);
select * from user where sub_category like '%GOP%';

create index debate on tagged(hashtagname);
select * from tagged where hashtagname like '%Debate%';

create index ohio on user(ofstate);
select * from user where ofstate like '%Ohio%';

create index u on user(screen_name);

drop index dem on user;
drop index debate on tagged;
drop index ohio on user
drop index u on user;
