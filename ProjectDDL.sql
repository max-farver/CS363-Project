DROP SCHEMA IF EXISTS group5;
CREATE SCHEMA group5;
USE group5;

CREATE TABLE user (
  screen_name VARCHAR(80),
  name VARCHAR(80) NOT NULL,
  sub_category VARCHAR(45),
  category VARCHAR(45),
  ofstate VARCHAR(45),
  numFollowers int,
  numFollowing int,
  PRIMARY KEY  (screen_name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tweets (
  tid varchar(50),
  textbody VARCHAR(240),
  retweet_count int NOT NULL,
  retweeted int NOT NULL,
  theDay int,
  theMonth int,
  theYear int,
  created_at bigint,
  posting_user VARCHAR(80) NOT NULL,
  foreign key (posting_user) references user(screen_name) on delete cascade,
  PRIMARY KEY  (tid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tagged (
  tid varchar(50),
  hashtagname VARCHAR(80),
  foreign key (tid) references tweets(tid) on delete cascade,
  PRIMARY KEY  (tid, hashtagname)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE mentioned (
  tid varchar(50),
  screen_name VARCHAR(80),
  foreign key (tid) references tweets(tid) on delete cascade,
  foreign key (screen_name) references user(screen_name) on delete cascade,
  PRIMARY KEY  (tid, screen_name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE urlused (
  tid varchar(50),
  url VARCHAR(500),
  constraint fk_tweet_url foreign key (tid) references tweets(tid) on delete cascade,
  PRIMARY KEY  (tid, url)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
