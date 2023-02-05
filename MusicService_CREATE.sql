CREATE TABLE IF NOT EXISTS genre (
	id     SERIAL          PRIMARY KEY,
	name   VARCHAR(60)     NOT NULL
);

CREATE TABLE IF NOT EXISTS artist (
	id     SERIAL          PRIMARY KEY,
	name   VARCHAR(60)     NOT NULL
);

CREATE TABLE IF NOT EXISTS artist_genre (
	artist_id      INTEGER     NOT NULL    REFERENCES artist(id),
	genre_id       INTEGER     NOT NULL    REFERENCES genre(id),
	CONSTRAINT pk PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE IF NOT EXISTS album (
	id     SERIAL          PRIMARY KEY,
	name   VARCHAR(60)     NOT NULL,
	year   INTEGER         NOT NULL
);

CREATE TABLE IF NOT EXISTS artist_album (
	artist_id  INTEGER     NOT NULL    REFERENCES artist(id),
	album_id   INTEGER     NOT NULL    REFERENCES album(id),
	PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE IF NOT EXISTS track (
	id         SERIAL          PRIMARY KEY,
	name       VARCHAR(60)     NOT NULL,
	duration   INTEGER         NOT NULL,
	album_id   INTEGER         REFERENCES album(id)
);

CREATE TABLE IF NOT EXISTS compilation (
	id     SERIAL          PRIMARY KEY,
	name   VARCHAR(60)     NOT NULL,
	year   INTEGER         NOT NULL 
);

CREATE TABLE IF NOT EXISTS compilation_track (
	compilation_id     INTEGER     NOT NULL    REFERENCES compilation(id),
	track_id           INTEGER     NOT NULL    REFERENCES track(id),
	PRIMARY KEY (compilation_id, track_id)
);