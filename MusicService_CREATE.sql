CREATE TABLE IF NOT EXISTS genre (
	genre_id     SERIAL          PRIMARY KEY,
	genre_name   VARCHAR(60)     NOT NULL    UNIQUE 
);

CREATE TABLE IF NOT EXISTS artist (
	artist_id     SERIAL          PRIMARY KEY,
	artist_name   VARCHAR(100)     NOT NULL    UNIQUE 
);

CREATE TABLE IF NOT EXISTS artist_genre (
	artist_id      INTEGER     NOT NULL    REFERENCES artist(artist_id),
	genre_id       INTEGER     NOT NULL    REFERENCES genre(genre_id),
	CONSTRAINT pk_artist_genre  PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE IF NOT EXISTS album (
	album_id         SERIAL              PRIMARY KEY,
	album_name       VARCHAR(100)        NOT NULL,
	album_year     INTEGER             NOT NULL        CHECK (album_year > 1900)
);

CREATE TABLE IF NOT EXISTS artist_album (
	artist_id  INTEGER     NOT NULL    REFERENCES artist(artist_id),
	album_id   INTEGER     NOT NULL    REFERENCES album(album_id),
	PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE IF NOT EXISTS track (
	track_id       SERIAL          PRIMARY KEY,
	track_name     VARCHAR(400)    NOT NULL,
	duration       INTEGER         NOT NULL        CHECK ("duration" > 0),
	album_id       INTEGER         REFERENCES album(album_id),
	CONSTRAINT unique_track_name_in_album          UNIQUE (track_name, album_id)
);

CREATE TABLE IF NOT EXISTS compilation (
	compilation_id     SERIAL          PRIMARY KEY,
	compilation_name   VARCHAR(60)     NOT NULL,
	compilation_year   INTEGER         NOT NULL        CHECK (compilation_year > 1900) 
);

CREATE TABLE IF NOT EXISTS compilation_track (
	compilation_id     INTEGER     NOT NULL    REFERENCES compilation(compilation_id),
	track_id           INTEGER     NOT NULL    REFERENCES track(track_id),
	CONSTRAINT pk_compilation_track            PRIMARY KEY (compilation_id, track_id)
);