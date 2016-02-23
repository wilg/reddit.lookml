- explore: comment_words
 
- view: comment_words
  derived_table:
    sql: |
     SELECT a.id as id, a.word as word, b.ssword IS NOT NULL as is_common
     FROM FLATTEN((
       SELECT id, LOWER(REGEXP_REPLACE(SPLIT(body, ' '), r'\W', '')) as word
          FROM ${comment.SQL_TABLE_NAME} stories
       ), word) as a
     LEFT JOIN (
        SELECT LOWER(REGEXP_REPLACE(word, r'\W', '')) as ssword
        , count(distinct corpus) as c 
        FROM [publicdata:samples.shakespeare] 
        GROUP BY 1 
        ORDER BY 2 
        DESC 
        LIMIT 500) as b
      ON a.word = b.ssword  
  
  fields:

    - dimension: word
    
    - dimension: comment_id
    
    - dimension: is_common
      type: yesno
      
    - measure: count
      type: count
