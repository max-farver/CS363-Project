delimiter //

drop procedure if exists group5.Q1;//

CREATE PROCEDURE group5.Q1(k int(3), mon int(2), yea int(4))
BEGIN
	select t.retweet_count, t.textbody, t.posting_user, u.category, u.sub_category
	from tweets t, user u
	where t.theMonth = mon and t.theYear = yea and t.posting_user = u.screen_name
	order by t.retweet_count desc limit k;
END //

 drop procedure if exists group5.Q3;//

 CREATE PROCEDURE group5.Q3(k int(3), yea int(4))
 BEGIN
 UPDATE user
 	SET ofstate = 'Florida'
 	WHERE ofstate = 'FL';

 	SELECT 
		(LENGTH(GROUP_CONCAT(DISTINCT user.ofState
					SEPARATOR ',')) - LENGTH(GROUP_CONCAT(DISTINCT user.ofState
					SEPARATOR ''))) AS len,
		GROUP_CONCAT(DISTINCT user.ofState
			SEPARATOR ',') AS list_of_states,
		tag.hashtagname
	FROM
		tagged tag
			INNER JOIN
		tweets ON tweets.tid = tag.tid
			INNER JOIN
		user ON user.screen_name = tweets.posting_user
	WHERE
    tweets.theYear = yea
GROUP BY tag.hashtagname
ORDER BY len DESC
LIMIT k;
 END //

drop procedure if exists group5.Q9;//
CREATE PROCEDURE group5.Q9(k int(3), cat varchar(30))
BEGIN
	select u.screen_name, u.sub_category, u.numFollowers
	from user u
	where u.sub_category like cat
	order by u.numFollowers desc limit k;
END //

drop procedure if exists group5.Q11;//
CREATE PROCEDURE group5.Q11(k int(3), sta varchar(30), mon int(2), yea int(4), hashy varchar(50))
BEGIN
	select t.textbody, tag.hashtagname, u.screen_name, u.sub_category
	from user u inner join tweets t on t.posting_user = u.screen_name
	inner join tagged tag on tag.tid = t.tid
	where (u.sub_category like '%GOP%' or u.sub_category like '%Democrat%')
	and u.ofstate like sta and tag.hashtagname like hashy and t.theMonth = mon and t.theYear = yea
	limit k;
END //

drop procedure if exists group5.Q15;//
CREATE PROCEDURE group5.Q15(subCat varchar(50), mon int(2), yea int(4))
BEGIN
	select u.screen_name, u.ofstate, GROUP_CONCAT(url.url SEPARATOR ',') as list_url
	from user u inner join tweets t on t.posting_user = u.screen_name
	inner join urlused url on url.tid = t.tid
	where u.sub_category like subCat and t.theMonth = mon and t.theYear = yea
	group by u.screen_name;
END //

drop procedure if exists group5.Q18;
//
CREATE PROCEDURE group5.Q18(k int(3), subCat varchar(50), mon int(2), yea int(4))
BEGIN
	select u1.screen_name, u1.ofstate, GROUP_CONCAT(distinct u2.screen_name SEPARATOR ',') as list_of_mentions
	from user u1 inner join mentioned on u1.screen_name = mentioned.screen_name
	inner join tweets on tweets.tid = mentioned.tid
	inner join user u2 on u2.screen_name = tweets.posting_user
	where u2.sub_category like subCat and tweets.theMonth = mon and tweets.theYear = yea
	group by u1.screen_name
	order by count(mentioned.screen_name) desc
	limit k;
END //

drop procedure if exists group5.ins;//
CREATE PROCEDURE group5.ins(screen_name varchar(80), name varchar(80), sub_category varchar(45),category varchar(45), ofstate varchar(45), numFollowers int(11), numFollowing int(11))
BEGIN
	
    IF not exists (select 1 from group5.user where user.screen_name = screen_name)
	then
		insert into group5.user value (screen_name, name, sub_category, category, ofstate, numFollowers, numFollowing);
	END IF;
END //

drop procedure if exists group5.del;
//
CREATE PROCEDURE group5.del(toDel varchar(80))
BEGIN
	set FOREIGN_KEY_CHECKS = 1;
	delete FROM group5.user
	where screen_name = toDel;
END //

delimiter ; 
