-- количество исполнителей в каждом жанре;
  SELECT g.genre_name , COUNT(*)  
    FROM genre g 
    JOIN artist_genre a     USING (genre_id) 
GROUP BY g.genre_name 
ORDER BY COUNT(*)   DESC ;


--количество треков, вошедших в альбомы 2019-2020 годов;
SELECT COUNT(*) 
  FROM track t 
  JOIN album a  USING(album_id); 

--средняя продолжительность треков по каждому альбому;
  SELECT a.album_name , AVG(t.duration) 
    FROM track t 
    JOIN album a USING (album_id)
GROUP BY a.album_name ;

--все исполнители, которые не выпустили альбомы в 2020 году;
   SELECT ar.artist_name 
     FROM artist ar 
    WHERE ar.artist_id  NOT IN  
	       (SELECT aa.artist_id 
	          FROM artist_album aa 
	          JOIN album al    USING (album_id)
	         WHERE al.album_year = 2020
	       );

--названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
SELECT DISTINCT c.compilation_name  
           FROM compilation c 
           JOIN compilation_track ct    USING (compilation_id) 
           JOIN track t                 USING (track_id)
           JOIN album al                 USING (album_id)
           JOIN artist_album aa         USING (album_id)
           JOIN artist ar               USING (artist_id)
          WHERE ar.artist_name = 'deadmau5';

--название альбомов, в которых присутствуют исполнители более 1 жанра;
  SELECT al.album_name, COUNT(ag.genre_id)  
    FROM album al 
    JOIN artist_album aa    USING (album_id)
    JOIN artist ar          USING (artist_id)
    JOIN artist_genre ag    USING (artist_id)
GROUP BY al.album_name  
  HAVING COUNT(ag.genre_id) > 1;

--наименование треков, которые не входят в сборники;
   SELECT t.track_name  
     FROM track t 
LEFT JOIN compilation_track c USING(track_id) 
    WHERE c.track_id IS NULL;

--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
SELECT ar.artist_name 
  FROM artist ar
  JOIN artist_album aa  USING (artist_id)
  JOIN album al         USING (album_id) 
  JOIN track t          USING (album_id)
  JOIN 
        (SELECT MIN(duration) min_duration 
           FROM track
       ) t2 
    ON t2.min_duration = t.duration ;

--название альбомов, содержащих наименьшее количество треков.
SELECT      a.album_name, COUNT (t.track_id) AS tracks_count
FROM        album a 
JOIN        track t USING (album_id)
GROUP BY    a.album_name 
HAVING      COUNT (t.track_id) = 
        (SELECT     COUNT (t.track_id) AS tracks_count
        FROM        album a 
        JOIN        track t USING (album_id)
        GROUP BY    a.album_name
        ORDER BY    COUNT (t.track_id)
        LIMIT 1);