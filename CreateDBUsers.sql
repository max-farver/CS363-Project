CREATE USER 'cs363'@'%1' IDENTIFIED WITH mysql_native_password BY 'speedIsAnUnderratedMovie';
GRANT SELECT, DROP, CREATE, INSERT, DELETE ON political_tweets.* TO 'cs363'@'%1';
GRANT TRIGGER ON political_tweets.* TO 'cs363'@'%1';
FLUSH PRIVILEGES;