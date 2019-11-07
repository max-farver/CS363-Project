DROP SCHEMA IF EXISTS political_tweets;
CREATE SCHEMA political_tweets;
USE political_tweets;

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
  tid bigint,
  textbody VARCHAR(240),
  retweet_count int NOT NULL,
  retweeted int NOT NULL,
  created_at datetime,
  theDay int,
  theMonth int,
  theYear int,
  posting_user VARCHAR(80) NOT NULL,
  foreign key (posting_user) references user(screen_name),
  PRIMARY KEY  (tid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tagged (
  tid bigint,
  hashtagname VARCHAR(80),
  foreign key (tid) references tweets(tid),
  PRIMARY KEY  (tid, hashtagname)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE mentioned (
  tid bigint,
  screen_name VARCHAR(80),
  foreign key (tid) references tweets(tid),
  foreign key (screen_name) references user(screen_name),
  PRIMARY KEY  (tid, screen_name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE urlused (
  tid bigint,
  url VARCHAR(500),
  foreign key (tid) references tweets(tid),
  PRIMARY KEY  (tid, url)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;