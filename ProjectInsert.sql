use political_tweets;

SHOW VARIABLES LIKE "secure_file_priv";

SET FOREIGN_KEY_CHECKS = 0;

Load Data Infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user.txt'
Into Table user
Fields Terminated By ';' Optionally Enclosed By '"'
Lines Terminated By '\n'
Ignore 1 Lines
(screen_name, name, sub_category, category, ofstate, numFollowers, numFollowing);

Load Data Infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tweets.csv'
Into Table tweets
Fields Terminated By ';' Optionally Enclosed by '"'
Lines Terminated By '\n'
Ignore 1 Lines
(tid, textbody, retweet_count, retweeted, @col5, posting_user)
set theDay = day(STR_TO_DATE(@posted,'%Y-%m-%d %H:%i:%s')),
	theMonth =  month(STR_TO_DATE(@posted,'%Y-%m-%d %H:%i:%s')),
	theYear =  year(STR_TO_DATE(@posted,'%Y-%m-%d %H:%i:%s')),
	created_at = UNIX_TIMESTAMP(@posted);


Load Data Infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tagged.txt'
Into Table tagged
Fields Terminated By ';'
Lines Terminated By '\n'
Ignore 1 Lines
(tid, hashtagname);

Load Data Infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mentioned.txt'
Into Table mentioned
Fields Terminated By ';'
Ignore 1 Lines
(tid, screen_name);

Load Data Infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/urlused.txt'
Into Table urlused
Fields Terminated By ';'
Lines Terminated By '\n'
Ignore 1 Lines
(tid, url);


