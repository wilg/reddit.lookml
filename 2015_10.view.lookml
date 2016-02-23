- view: 2015_10
  sql_table_name: |
      [fh-bigquery:reddit_comments.[2015_10]]
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: archived
    type: yesno
    sql: ${TABLE}.archived

  - dimension: author
    type: string
    sql: ${TABLE}.author

  - dimension: author_flair_css_class
    type: string
    sql: ${TABLE}.author_flair_css_class

  - dimension: author_flair_text
    type: string
    sql: ${TABLE}.author_flair_text

  - dimension: body
    type: string
    sql: ${TABLE}.body

  - dimension: controversiality
    type: number
    sql: ${TABLE}.controversiality

  - dimension: created_utc
    type: number
    sql: ${TABLE}.created_utc

  - dimension: distinguished
    type: string
    sql: ${TABLE}.distinguished

  - dimension: downs
    type: number
    sql: ${TABLE}.downs

  - dimension: gilded
    type: number
    sql: ${TABLE}.gilded

  - dimension: link_id
    type: string
    sql: ${TABLE}.link_id

  - dimension: name
    type: string
    sql: ${TABLE}.name

  - dimension: parent_id
    type: string
    sql: ${TABLE}.parent_id

  - dimension: retrieved_on
    type: number
    sql: ${TABLE}.retrieved_on

  - dimension: score
    type: number
    sql: ${TABLE}.score

  - dimension: score_hidden
    type: yesno
    sql: ${TABLE}.score_hidden

  - dimension: subreddit
    type: string
    sql: ${TABLE}.subreddit

  - dimension: subreddit_id
    type: string
    sql: ${TABLE}.subreddit_id

  - dimension: ups
    type: number
    sql: ${TABLE}.ups

  - measure: count
    type: count
    approximate_threshold: 100000
    drill_fields: [id, name]

