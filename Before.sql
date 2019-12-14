use group5;

-- Question 1
-- Inputs are month, year, number of tweets to return
-- We can't load tweets into the data set because of the semi-colons
select t.retweet_count, t.textbody, t.posting_user, u.category, u.sub_category
from tweets t, user u
where t.theMonth = 1 and t.theYear = 2016 and t.posting_user = u.screen_name
order by t.retweet_count desc limit 5;

-- Q3
-- Inputs are number of hashtags to return and year
UPDATE user
SET ofstate = 'Florida'
WHERE ofstate = 'FL';

select (length(GROUP_CONCAT(distinct user.ofState SEPARATOR ',')) - length(GROUP_CONCAT(distinct user.ofState SEPARATOR '')))as len, GROUP_CONCAT(distinct user.ofState SEPARATOR ',') as list_of_states, tag.hashtagname
from tagged tag inner join tweets on tweets.tid = tag.tid
inner join user on user.screen_name = tweets.posting_user
where tweets.theYear = 2016
group by tag.hashtagname
order by len desc
limit 5;

-- Q6
-- Find k users who used at least one of the hashtags in a given list of hashtags in their tweets. 
-- Show the user’s screen name and the state the user lives in descending order of the number of this user’s followers
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

-- Q9
-- Find top k most followed users in a given party. Show the user’s screen name, the user’s party, 
-- and the number of followers in descending order of the number of followers.
select u.screen_name, u.sub_category, u.numFollowers
from user u
where u.sub_category like '%GOP%'
order by u.numFollowers desc limit 5;

select u.screen_name, u.sub_category, u.numFollowers
from user u
where u.sub_category like '%Democrat%'
order by u.numFollowers desc limit 5;

-- Q10
-- Find the list of distinct hashtags that appeared in one of the states in a given list in a given month of a given year; 
-- show the list of the hashtags and the names of the states in which they appeared. 
select distinct tag.hashtagname, u.ofstate
from tagged tag, user u, tweets t
where tag.tid = t.tid and t.posting_user = u.screen_name and t.theMonth = 1 and t.theYear = 2016 and
(u.ofstate like '%Ohio%' or u.ofstate like '%Alaska%' or u.ofstate like '%Alabama%');

-- Q11
-- Find k tweets (with the given hashtag) posted by republican (GOP) or democrat members of a given state in a given 
-- month of a given year. Show the tweet text, the hashtag, the screen name of the posting user, and the users’ party
select t.textbody, tag.hashtagname, u.screen_name, u.sub_category
from user u inner join tweets t on t.posting_user = u.screen_name
inner join tagged tag on tag.tid = t.tid
where (u.sub_category like '%GOP%' or u.sub_category like '%Democrat%')
and u.ofstate like '%Ohio%' and tag.hashtagname like '%Ohio%' and t.theMonth = 1 and t.theYear = 2016
limit 5;

-- Q15
-- Find users in a given sub category along with the list of URLs used in the user’s tweets in a given month of a given 
-- year. Show the user’s screen name, the state the user lives, and the list of URLs
select u.screen_name, u.ofstate, GROUP_CONCAT(url.url SEPARATOR ',') as list_url
from user u inner join tweets t on t.posting_user = u.screen_name
inner join urlused url on url.tid = t.tid
where u.sub_category like '%GOP%' and t.theMonth = 1 and t.theYear = 2016
group by u.screen_name;

-- Q18
-- Find k users who were mentioned the most in tweets of users of a given party in a given month of a given year. Show 
-- the user’s screen name, user’s state, and the list of the screen name of the user(s) 
-- who mentioned this user in descending order of the number of tweets mentioning this user.
select u1.screen_name, u1.ofstate, GROUP_CONCAT(distinct u2.screen_name SEPARATOR ',') as list_of_mentions
from user u1 inner join mentioned on u1.screen_name = mentioned.screen_name
inner join tweets on tweets.tid = mentioned.tid
inner join user u2 on u2.screen_name = tweets.posting_user
where u2.sub_category like '%GOP%' and tweets.theMonth = 1 and tweets.theYear = 2016
group by u1.screen_name
order by count(mentioned.screen_name) desc
limit 5;

-- Q23
-- Find k most used hashtags with the count of tweets it appeared posted by a given
-- sub-category of users in a list of months. Show the hashtag name and the count in descending order of the count
select tag.hashtagname, count(t.tid) as num_uses, t.theMonth as month_posted
from tagged tag inner join tweets t on tag.tid = t.tid
inner join user on t.posting_user = user.screen_name
where user.sub_category like '%GOP%' and t.theYear = 2016 
and (t.theMonth = 1 or t.theMonth = 2 or t.theMonth = 3)
group by tag.hashtagname
order by num_uses desc limit 5;
                                                                                        

                                                                                        
-- Delete 
SET FOREIGN_KEY_CHECKS = 0;
Delete user, mentioned, tweets, tagged, urlused
from user inner join tweets on user.screen_name = tweets.posting_user
inner join mentioned on tweets.tid = mentioned.tid
inner join tagged on tweets.tid = tagged.tid
inner join urlused on tweets.tid = urlused.tid
where user.screen_name like '%OhioSenateGOP%';

Delete user, mentioned, tweets, tagged
from user inner join tweets on user.screen_name = tweets.posting_user
inner join mentioned on tweets.tid = mentioned.tid
inner join tagged on tweets.tid = tagged.tid
where user.screen_name like '%OhioSenateGOP%';

Delete user, mentioned, tweets, urlused
from user inner join tweets on user.screen_name = tweets.posting_user
inner join mentioned on tweets.tid = mentioned.tid
inner join urlused on tweets.tid = urlused.tid
where user.screen_name like '%OhioSenateGOP%';

Delete user, tagged, tweets, urlused
from user inner join tweets on user.screen_name = tweets.posting_user
inner join tagged on tweets.tid = tagged.tid
inner join urlused on tweets.tid = urlused.tid
where user.screen_name like '%OhioSenateGOP%';

Delete tweets, mentioned
from tweets inner join mentioned on tweets.tid = mentioned.tid
where tweets.posting_user like '%OhioSenateGOP%';

Delete tweets, urlused
from tweets inner join urlused on tweets.tid = urlused.tid
where tweets.posting_user like '%OhioSenateGOP%';

Delete tweets, tagged
from tweets inner join tagged on tweets.tid = tagged.tid
where tweets.posting_user like '%OhioSenateGOP%';

Delete from tweets
where tweets.posting_user like '%OhioSenateGOP%';

Delete from user
where screen_name like '%OhioSenateGOP%';
