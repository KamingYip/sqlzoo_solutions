/* 
sqlzoo solutions
Topic: The JOIN operation
URL: https://sqlzoo.net/wiki/The_JOIN_operation
Editor: Kaming Yip
LinkedIn: https://www.linkedin.com/in/kamingyip/
*/

/* 
1. Modify it to show the matchid and player name for all goals scored by Germany.
To identify German players, check for: teamid = 'GER'
*/
SELECT matchid, player
FROM goal 
WHERE teamid = 'GER'

/*
2. Show id, stadium, team1, team2 for just game 1012
*/
SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012

/*
3. Modify it to show the player, teamid, stadium and mdate for every German goal.
*/
SELECT player, teamid, game.stadium, game.mdate
FROM goal
JOIN game ON goal.matchid = game.id
JOIN eteam ON eteam.id = goal.teamid
WHERE eteam.teamname = 'Germany'

/*
4. Show the team1, team2 and player for every goal scored by a player
called Mario player LIKE 'Mario%'
*/
SELECT team1, team2, goal.player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE player LIKE 'Mario%'

/*
5. Show player, teamid, coach, gtime for all goals scored in the first
10 minutes gtime<=10
*/
SELECT player, teamid, eteam.coach, gtime
FROM goal
JOIN eteam ON goal.teamid = eteam.id
WHERE gtime <= 10

/*
6. List the dates of the matches and the name of the team in which
'Fernando Santos' was the team1 coach.
*/
SELECT mdate, eteam.teamname
FROM game
JOIN eteam ON game.team1 = eteam.id
WHERE eteam.coach = 'Fernando Santos'

/*
7. List the player for every goal scored in a game where the stadium
was 'National Stadium, Warsaw'
*/
SELECT player
FROM goal
JOIN game ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw'

/*
8. Instead show the name of all players who scored a goal against Germany.
*/
SELECT DISTINCT player
FROM goal
JOIN game ON goal.matchid = game.id
WHERE (game.team1 = 'GER' OR game.team2 = 'GER') AND goal.teamid != 'GER'

/*
9. Show teamname and the total number of goals scored.
*/
SELECT eteam.teamname, COUNT(*) AS Goal_Scored
FROM goal
JOIN eteam ON goal.teamid = eteam.id
GROUP BY eteam.teamname

/*
10. Show the stadium and the number of goals scored in each stadium.
*/
SELECT game.stadium, COUNT(*) AS Goal_Scored
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY game.stadium

/*
11. For every match involving 'POL', show the matchid, date and the
number of goals scored.
*/
SELECT goal.matchid, game.mdate, COUNT(*) AS Goal_Scored
FROM goal
JOIN game ON goal.matchid = game.id
WHERE game.team1 = 'POL' OR game.team2 = 'POL'
GROUP BY goal.matchid, game.mdate

/*
12. For every match where 'GER' scored, show matchid, match date and
the number of goals scored by 'GER'
*/
SELECT goal.matchid, game.mdate, COUNT(*) AS Goal_Scored
FROM goal JOIN game ON goal.matchid = game.id
WHERE goal.teamid = 'GER'
GROUP BY goal.matchid, game.mdate

/*
13. List every match with the goals scored by each team as shown.
Sort your result by mdate, matchid, team1 and team2.
*/
SELECT game.mdate,
game.team1,
SUM(CASE WHEN game.team1 = goal.teamid THEN 1 ELSE 0 END) AS score1,
game.team2,
SUM(CASE WHEN game.team2 = goal.teamid THEN 1 ELSE 0 END) AS score2
FROM game
LEFT JOIN goal ON game.id = goal.matchid
GROUP BY game.mdate, goal.matchid, game.team1, game.team2
ORDER BY game.mdate, goal.matchid, game.team1, game.team2
