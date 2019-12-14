CREATE USER 'cs363'@'%1' IDENTIFIED WITH mysql_native_password BY 'speedIsAnUnderratedMovie';
GRANT ALL ON group5.* TO 'cs363'@'%1';
FLUSH PRIVILEGES;
