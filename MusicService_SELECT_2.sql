-- количество исполнителей в каждом жанре;
  SELECT g."name" , COUNT(*)  
    FROM genre g 
    JOIN artist_genre a 
      ON a.genre_id = g.id 
GROUP BY g."name" 
ORDER BY COUNT(*) DESC ;


--количество треков, вошедших в альбомы 2019-2020 годов;
SELECT COUNT(*) 
  FROM track t 
  JOIN album a 
    ON a.id = t.album_id; 

--средняя продолжительность треков по каждому альбому;
  SELECT a."name" , AVG(t.duration) 
    FROM track t 
    JOIN album a 
      ON a.id = t.album_id 
GROUP BY a."name" ;

--все исполнители, которые не выпустили альбомы в 2020 году;
   SELECT ar."name" 
     FROM artist ar 
LEFT JOIN 
	     (SELECT aa.artist_id 
	        FROM artist_album aa 
	        JOIN album al 
	          ON al.id = aa.album_id 
	       WHERE al."year" = 2020
	     ) a2 
       ON a2.artist_id = ar.id 
    WHERE a2.artist_id IS NULL;

--названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
SELECT DISTINCT c."name"  
           FROM compilation c 
           JOIN compilation_track c2 
             ON c2.compilation_id = c.id 
           JOIN track t 
             ON t.id = c2.track_id 
           JOIN album a 
             ON a.id = t.album_id 
           JOIN artist_album a2 
             ON a2.album_id = a.id 
           JOIN artist a3 
             ON a3.id = a2.artist_id 
          WHERE a3."name" = 'deadmau5';

--название альбомов, в которых присутствуют исполнители более 1 жанра;
  SELECT a."name", COUNT(a4.genre_id)  
    FROM album a 
    JOIN artist_album a2 
      ON a2.album_id = a.id 
    JOIN artist a3 
      ON a3.id = a2.artist_id 
    JOIN artist_genre a4 
      ON a4.artist_id = a3.id 
GROUP BY a."name" 
  HAVING COUNT(a4.genre_id) > 1;

--наименование треков, которые не входят в сборники;
   SELECT t."name"  
     FROM track t 
LEFT JOIN compilation_track c ON c.track_id = t.id 
    WHERE c.track_id IS NULL;

--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
SELECT ar."name"  
  FROM artist ar
  JOIN artist_album aa ON aa.artist_id = ar.id 
  JOIN album al ON al.id = aa.album_id 
  JOIN track t ON t.album_id = al.id 
  JOIN 
        (SELECT MIN(duration) min_duration 
           FROM track
       ) t2 
    ON t2.min_duration = t.duration ;

--название альбомов, содержащих наименьшее количество треков.
SELECT a."name"  
FROM album a 
JOIN 
    ( SELECT t.album_id, COUNT(*) t_count 
        FROM track t 
    GROUP BY t.album_id
    ) t_counts 
  ON t_counts.album_id = a.id 
JOIN 
    (SELECT MIN(t_count) m 
       FROM 
            ( SELECT t.album_id, COUNT(*) t_count 
                FROM track t 
            GROUP BY t.album_id
            ) t_counts) min_counts
  ON min_counts.m = t_counts.t_count;