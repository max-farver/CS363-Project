use political_tweets;

SHOW VARIABLES LIKE "secure_file_priv";

 -- SET FOREIGN_KEY_CHECKS = 0;

Load Data Infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user.txt'
Into Table user
Fields Terminated By ';' Optionally Enclosed By '"'
Lines Terminated By '\n'
Ignore 1 Lines
(screen_name, name, sub_category, category, ofstate, numFollowers, numFollowing);

Load Data Infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tweets.txt'
Into Table tweets
Fields Terminated By ';'
Lines Terminated By '\n'
Ignore 1 Lines
(tid, textbody, retweet_count, retweeted, @var1, posting_user)
set posted = STR_TO_DATE(REPLACE(@var1,'"',''), '%Y-%m-%d %h:%i:%s');

Load Data Infile 'C:\Users\tdpotter58\Documents\Project\mentioned.csv'
Into Table mentioned
Fields Terminated By ';' Optionally Enclosed By '"'
Lines Terminated By '\n'
Ignore 1 Lines
(tid, screen_name);

Load Data Infile 'C:\Users\tdpotter58\Documents\Project\tagged.csv'
Into Table tagged
Fields Terminated By ';' Optionally Enclosed By '"'
Lines Terminated By '\n'
Ignore 1 Lines
(hashtagname);

Load Data Infile 'C:\Users\tdpotter58\Documents\Project\urlused.csv'
Into Table urlused
Fields Terminated By ';' Optionally Enclosed By '"'
Lines Terminated By '\n'
Ignore 1 Lines
(tid, url);

Load Data Infile 'C:\Users\tdpotter58\Documents\Project\mentioned.csv'
Into Table mentioned
Fields Terminated By ';' Optionally Enclosed By '"'
Lines Terminated By '\n'
Ignore 1 Lines
(tid, screen_name);
