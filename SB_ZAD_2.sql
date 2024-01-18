SET serveroutput ON SIZE 30000;

-- Zadanie-1
CREATE TABLE movies AS SELECT * FROM ztpd.movies;

-- Zadanie-2
SELECT * FROM movies;
descr movies;

-- Zadanie-3
SELECT id, title
FROM movies 
WHERE cover 
IS NULL;

-- Zadanie-4
SELECT id, title, dbms_lob.getlength(cover) AS filesize
FROM movies
WHERE cover 
IS NOT NULL;

-- Zadanie-5
SELECT id, title, dbms_lob.getlength(cover) AS filesize
FROM movies
WHERE cover 
IS NULL;

-- Zadanie-6
SELECT * FROM ALL_DIRECTORIES;

-- Zadanie-7

UPDATE movies
SET 
    cover = empty_blob(),
    mime_type = 'image/jpeg'
WHERE id = 66;

SELECT * FROM movies 
WHERE id = 66;

-- Zadanie-8
SELECT id, title, dbms_lob.getlength(cover) AS filesize
FROM movies
WHERE id in (65, 66);

-- Zadanie-9
DECLARE


    bl blob;
    img_file bfile := bfilename('TPD_DIR', 'escape.jpg');
BEGIN
    

    SELECT cover 
    INTO bl
    FROM movies 
    WHERE id = 66
    FOR UPDATE;
    

    dbms_lob.fileopen(img_file, dbms_lob.file_readonly);
    dbms_lob.loadfromfile(bl, img_file, dbms_lob.getlength(img_file));
    dbms_lob.fileclose(img_file);
    

    COMMIT;
END;

SELECT id, title, dbms_lob.getlength(cover) AS filesize
FROM movies
WHERE id = 66;

-- Zadanie-10
CREATE TABLE temp_covers (
    movie_id NUMBER(12),
    IMAGE bfile,
    mime_type VARCHAR2(50)
);

descr temp_covers;

-- Zadanie-11
DECLARE
    bl blob;
    img_file bfile := bfilename('TPD_DIR', 'eagles.jpg');
BEGIN
    INSERT INTO temp_covers
    VALUES (65, img_file, 'image/jpeg');
    COMMIT;
END;

-- Zadanie-12
SELECT movie_id, dbms_lob.getlength(image), mime_type
FROM temp_covers
WHERE movie_id = 65;

-- Zadanie-13
DECLARE
    bl blob;
    img_file bfile;
    mime VARCHAR2(100);
BEGIN
    SELECT image INTO img_file
    FROM temp_covers 
    WHERE movie_id = 65;
    SELECT mime_type INTO mime
    FROM temp_covers
    WHERE movie_id = 65;
    
    dbms_lob.createtemporary(bl, true);
    
    dbms_lob.fileopen(img_file, dbms_lob.file_readonly);
    dbms_lob.loadfromfile(bl, img_file, dbms_lob.getlength(img_file));
    dbms_lob.fileclose(img_file);
    
    UPDATE movies
    SET cover = bl, mime_type = mime
    WHERE id = 65;
    
    dbms_lob.freetemporary(bl); 
    COMMIT;
END;


-- Zadanie-14
SELECT id, dbms_lob.getlength(cover), mime_type
FROM movies
WHERE id in (65, 66);

-- Zadanie-15
DROP TABLE movies;
