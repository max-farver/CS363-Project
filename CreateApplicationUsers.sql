use political_tweets;

create table appuser (name VARCHAR(50), pwd VARCHAR(50) NOT NULL, privilege VARCHAR(8), PRIMARY KEY(name));

insert into appuser values ('Tim', sha1('lightning'), 'all');
set@pwd='lightning';

insert into appuser values('Brett', sha1('mcQueen'), 'readonly');
set@pwd='mcQueen';

