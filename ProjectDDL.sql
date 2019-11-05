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
  tid int,
  textbody VARCHAR(240),
  retweet_count int NOT NULL,
  retweeted int NOT NULL,
  posted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  posting_user VARCHAR(45) NOT NULL,
  foreign key (posting_user) references user(screen_name),
  PRIMARY KEY  (tid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tagged (
  tid int,
  hashtagname VARCHAR(80),
  foreign key (tid) references tweets(tid),
  PRIMARY KEY  (tid, hashtagname)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE mentioned (
  tid int,
  screen_name VARCHAR(80),
  foreign key (tid) references tweets(tid),
  foreign key (screen_name) references user(screen_name),
  PRIMARY KEY  (tid, screen_name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE urlused (
  tid int,
  url VARCHAR(80),
  foreign key (tid) references tweets(tid),
  PRIMARY KEY  (tid, url)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;