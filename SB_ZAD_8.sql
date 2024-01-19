-- Zadanie-1
CREATE TABLE cytaty AS
SELECT * FROM ztpd.cytaty;


-- Zadanie-2
SELECT  autor, tekst
FROM    cytaty
WHERE lower(tekst) LIKE '%optymista%'
AND lower(tekst) LIKE '%pesymista%';


-- Zadanie-3
CREATE INDEX cytaty_idx 
ON      cytaty (tekst) INDEXTYPE IS ctxsys.context;
        

-- Zadanie-4
SELECT  autor, tekst
FROM    cytaty
WHERE   contains(tekst, 'optymista and pesymista') > 0;


-- Zadanie-5
SELECT  autor, tekst
FROM    cytaty
WHERE   contains(tekst, 'pesymista ~ optymista') > 0;


-- Zadanie-6
SELECT  autor, tekst
FROM    cytaty
WHERE   contains(tekst, 'near((optymista, pesymista), 3)') > 0;


-- Zadanie-7
SELECT  autor, tekst
FROM    cytaty
WHERE   contains(tekst, 'near((optymista, pesymista), 10)') > 0;
    

-- Zadanie-8
SELECT  autor, tekst
FROM    cytaty
WHERE   contains(tekst, 'życi%') > 0;


-- Zadanie-9
SELECT  autor, tekst, contains(tekst, 'życi%') score
FROM    cytaty
WHERE   contains(tekst, 'życi%') > 0;


-- Zadanie-10
SELECT  autor, tekst, contains(tekst, 'życi%') dopasowanie
FROM    cytaty
WHERE   contains(tekst, 'życi%') > 0
AND     ROWNUM <= 1
ORDER BY dopasowanie DESC;


-- Zadanie-11
SELECT  autor, tekst
FROM    cytaty
WHERE   contains(tekst, 'fuzzy(‘problem’)') > 0;


-- Zadanie-12
INSERT INTO cytaty VALUES(39, 'Bertrand Russell','To smutne, że głupcy są tacy pewni siebie, a ludzie rozsądni tacy pełni wątpliwości.');
COMMIT;


-- Zadanie-13
SELECT  autor, tekst
FROM    cytaty
WHERE   contains(tekst, 'głupcy') > 0;


-- Zadanie-14
SELECT * FROM dr$cytaty_idx$i
WHERE   token_text = 'głupcy';


-- Zadanie-15
DROP INDEX cytaty_idx;

CREATE INDEX cytaty_idx ON cytaty (tekst) INDEXTYPE IS ctxsys.context;


-- Zadanie-16
SELECT autor, tekst
FROM cytaty
WHERE contains(tekst, 'głupcy') > 0;
    

-- Zadanie-17
DROP INDEX cytaty_idx;
DROP TABLE cytaty;


-- Zadanie-1
CREATE TABLE quotes AS 
SELECT * FROM ztpd.quotes;


-- Zadanie-2
CREATE INDEX quotes_idx ON quotes (text) INDEXTYPE IS ctxsys.context;


-- Zadanie-3
SELECT * FROM quotes
WHERE contains(text, 'work') > 0;

SELECT * FROM quotes
WHERE contains(text, '$work') > 0;

SELECT * FROM quotes
WHERE contains(text, 'working') > 0;

SELECT * FROM quotes
WHERE contains(text, '$working') > 0;


-- Zadanie-4
SELECT * FROM quotes
WHERE contains(text, 'it') > 0;
    

-- Zadanie-5
SELECT * FROM ctx_stoplists;


-- Zadanie-6
SELECT * FROM ctx_stopwords;
    

-- Zadanie-7
DROP INDEX quotes_idx;

CREATE INDEX quotes_idx ON quotes(text)
        INDEXTYPE IS ctxsys.context PARAMETERS ( 'stoplist CTXSYS.EMPTY_STOPLIST' );


-- Zadanie-8 
SELECT * FROM quotes
WHERE contains(text, 'it') > 0;
--Tak

-- Zadanie-9
SELECT * FROM quotes
WHERE contains(text, 'fool and humans') > 0;


-- Zadanie-10
SELECT * FROM quotes
WHERE contains(text, 'fool and computer') > 0;
    

-- Zadanie-11
SELECT * FROM quotes
WHERE contains(text, '(fool and humans) within sentence') > 0;
    

-- Zadanie-12
DROP INDEX quotes_idx;


-- Zadanie-13
BEGIN
    ctx_ddl.create_section_group('nullgroup', 'NULL_SECTION_GROUP');
    ctx_ddl.add_special_section('nullgroup', 'SENTENCE');
    ctx_ddl.add_special_section('nullgroup', 'PARAGRAPH');
END;


-- Zadanie-14
CREATE INDEX quotes_idx ONquotes (text)
        INDEXTYPE IS ctxsys.context PARAMETERS ( 'section group nullgroup' );


-- Zadanie-15
SELECT * FROM quotes
WHERE contains(text, '(fool and humans) within sentence') > 0;

SELECT * FROM quotes
WHERE contains(text, '(fool and computer) within sentence') > 0;
    

-- Zadanie-16
SELECT * FROM quotes
WHERE contains(text, 'humans') > 0;
    

-- Zadanie-17
DROP INDEX quotes_idx;

BEGIN
    ctx_ddl.create_preference('lex_z_m', 'BASIC_LEXER');
    ctx_ddl.set_attribute('lex_z_m', 'printjoins', '_-');
    ctx_ddl.set_attribute('lex_z_m', 'index_text', 'YES');
END;

CREATE INDEX quotes_idx ON quotes (text)
        INDEXTYPE IS ctxsys.context PARAMETERS ( 'lexer lex_z_m' );
        

-- Zadanie-18 
SELECT * FROM quotes
WHERE contains(text, 'humans') > 0;
--Nie


-- Zadanie-19
SELECT * FROM quotes
WHERE contains(text, 'non\-humans') > 0;


-- Zadanie-20
DROP INDEX quotes_idx;
DROP TABLE quotes;