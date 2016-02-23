- view: sentiment_analysis

  fields:

    - dimension: sentiment
      sql_case: 
        Positive: | 
          (
            REGEXP_MATCH(${body}, r'(?i:lol)') OR
            REGEXP_MATCH(${body}, r'(?i:\:\))') OR
            REGEXP_MATCH(${body}, r'(?i:agree)') OR
            REGEXP_MATCH(${body}, r'(?i:sweet)') OR
            REGEXP_MATCH(${body}, r'(?i:yes)') OR
            REGEXP_MATCH(${body}, r'(?i:nice)') OR
            LOWER(RTRIM(LTRIM(${body}))) IN ('this', 'this.') OR
            REGEXP_MATCH(${body}, r'(?i:no problem)') OR
            REGEXP_MATCH(${body}, r'(?i:thank)')
            
          
            )
        Negative: true
        Not Classified: true