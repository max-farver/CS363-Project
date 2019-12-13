use political_tweets;

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

