delimiter //

drop procedure if exists political_tweets.Q1;//

CREATE PROCEDURE political_tweets.Q1()
BEGIN
	select t.retweet_count, t.textbody, t.posting_user, u.category, u.sub_category
	from tweets t, user u
	where t.theMonth = 1 and t.theYear = 2016 and t.posting_user = u.screen_name
	order by t.retweet_count desc limit 5;
END //

 drop procedure if exists political_tweets.Q3;//

 CREATE PROCEDURE political_tweets.Q3()
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
    tweets.theYear = 2016
GROUP BY tag.hashtagname
ORDER BY len DESC
LIMIT 5;
 END //

drop procedure if exists political_tweets.Q6;//
CREATE PROCEDURE political_tweets.Q6()
BEGIN
	select distinct u.screen_name, u.ofstate
	from user u inner join tweets on tweets.posting_user = u.screen_name
	inner join tagged on tagged.tid = tweets.tid
	where tagged.hashtagname like '%GOPDebate%' or tagged.hashtagname = '%DemDebate%'
	order by u.numFollowers desc
	limit 5;

	select distinct u.screen_name, u.ofstate
	from user u inner join tweets on tweets.posting_user = u.screen_name
	inner join tagged on tagged.tid = tweets.tid
	where tagged.hashtagname like '%HappyNewYear%' or tagged.hashtagname like '%NewYear%' or tagged.hashtagname like '%NewYears%'
	or tagged.hashtagname like '%NewYearsDay%'
	order by u.numFollowers desc
	limit 12;
END //

drop procedure if exists political_tweets.Q9;//
CREATE PROCEDURE political_tweets.Q9()
BEGIN
	select u.screen_name, u.sub_category, u.numFollowers
	from user u
	where u.sub_category like '%GOP%'
	order by u.numFollowers desc limit 5;

	select u.screen_name, u.sub_category, u.numFollowers
	from user u
	where u.sub_category like '%Democrat%'
	order by u.numFollowers desc limit 5;
END //

drop procedure if exists political_tweets.Q10;//
CREATE PROCEDURE political_tweets.Q10()
BEGIN
	select distinct tag.hashtagname, u.ofstate
from tagged tag, user u, tweets t
where tag.tid = t.tid and t.posting_user = u.screen_name and t.theMonth = 1 and t.theYear = 2016 and
(u.ofstate like '%Ohio%' or u.ofstate like '%Alaska%' or u.ofstate like '%Alabama%');
END //

drop procedure if exists political_tweets.Q11;//
CREATE PROCEDURE political_tweets.Q11()
BEGIN
	select t.textbody, tag.hashtagname, u.screen_name, u.sub_category
	from user u inner join tweets t on t.posting_user = u.screen_name
	inner join tagged tag on tag.tid = t.tid
	where (u.sub_category like '%GOP%' or u.sub_category like '%Democrat%')
	and u.ofstate like '%Ohio%' and tag.hashtagname like '%Ohio%' and t.theMonth = 1 and t.theYear = 2016
	limit 5;
END //

drop procedure if exists political_tweets.Q15;//
CREATE PROCEDURE political_tweets.Q15()
BEGIN
	select u.screen_name, u.ofstate, GROUP_CONCAT(url.url SEPARATOR ',') as list_url
	from user u inner join tweets t on t.posting_user = u.screen_name
	inner join urlused url on url.tid = t.tid
	where u.sub_category like '%GOP%' and t.theMonth = 1 and t.theYear = 2016
	group by u.screen_name;
END //

-- drop procedure if exists political_tweets.Q18;
-- CREATE PROCEDURE political_tweets.Q18()
-- BEGIN
-- 	from tagged tag, user u, tweets t
-- 	where tag.tid = t.tid and t.posting_user = u.screen_name and t.theMonth = 1 and t.theYear = 2016 and
-- 	(u.ofstate like '%Ohio%' or u.ofstate like '%Alaska%' or u.ofstate like '%Alabama%');
-- END //

-- drop procedure if exists political_tweets.Q23;
-- CREATE PROCEDURE political_tweets.Q23()
-- BEGIN
-- 	from tagged tag, user u, tweets t
-- 	where tag.tid = t.tid and t.posting_user = u.screen_name and t.theMonth = 1 and t.theYear = 2016 and
-- 	(u.ofstate like '%Ohio%' or u.ofstate like '%Alaska%' or u.ofstate like '%Alabama%');
-- END //

drop procedure if exists political_tweets.ins;//
CREATE PROCEDURE political_tweets.ins()
BEGIN
	insert into political_tweets.user value ("blah", "blah", "", "", "", 1, 1);
END //

-- drop procedure if exists political_tweets.del;
-- CREATE PROCEDURE political_tweets.del();
-- BEGIN
-- 	from tagged tag, user u, tweets t
-- 	where tag.tid = t.tid and t.posting_user = u.screen_name and t.theMonth = 1 and t.theYear = 2016 and
-- 	(u.ofstate like '%Ohio%' or u.ofstate like '%Alaska%' or u.ofstate like '%Alabama%');
-- END //

delimiter ; 