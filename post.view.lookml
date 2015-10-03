- view: post
  sql_table_name: "[fh-bigquery:reddit_posts.full_corpus_201509]"

  fields:

    - dimension: id
      type: string
      primary_key: true
      html: |
        {{linked_value}} 
        <a href="https://reddit.com/{{value}}" rel="noreferrer">
          <img width="16" height="16" src="https://www.reddit.com/favicon.ico" rel="noreferrer">
        </a>

    - dimension: author
      type: string
      html: |
        {{linked_value}} 
        <a href="https://www.reddit.com/user/{{value}}" rel="noreferrer">
          <img width="16" height="16" src="https://www.reddit.com/favicon.ico" rel="noreferrer">
        </a>

    - dimension: domain
      type: string
      html: |
        {{linked_value}} 
        <a href="http://{{value}}" rel="noreferrer">
          <img width="16" height="16" src="http://{{value}}/favicon.ico" rel="noreferrer">
        </a>
      sql: |
        CASE WHEN ${TABLE}.is_self THEN NULL ELSE ${TABLE}.domain END

    - dimension: subreddit
      type: string
      html: |
        {{linked_value}} 
        <a href="https://www.reddit.com/r/{{value}}" rel="noreferrer">
          <img width="16" height="16" src="https://www.reddit.com/favicon.ico" rel="noreferrer">
        </a>

    - dimension: selftext
      type: string

    - dimension: saved
      type: yesno

    - dimension: from_kind
      type: string

    - dimension: gilded
      type: number

    - dimension: from
      type: string

    - dimension: stickied
      type: yesno

    - dimension: title
      type: string

    - dimension: num_comments
      type: number

    - dimension: score
      type: number

    - dimension: retrieved_on
      type: number

    - dimension: nsfw
      label: NSFW
      description: Not Safe For Work
      type: yesno
      sql: ${TABLE}.over_18

    - dimension: thumbnail
      type: string
      sql: |
        CASE WHEN ${TABLE}.thumbnail LIKE "http%" THEN
          ${TABLE}.thumbnail
        ELSE
          NULL
        END
      html: |
        <img src="{{value}}" rel="noreferrer" style="max-width: 60px;">

    - dimension: subreddit_id
      type: string

    - dimension: hide_score
      type: yesno

    - dimension: link_flair_css_class
      type: string

    - dimension: author_flair_css_class
      type: string

    - dimension: downs
      type: number

    - dimension: archived
      type: yesno

    - dimension: self_post
      type: yesno
      sql: ${TABLE}.is_self

    - dimension: from_id
      type: string

#     - dimension: permalink
#       type: string

    - dimension: name
      type: string

    - dimension: url
      type: string

    - dimension: author_flair_text
      type: string

    - dimension: quarantine
      type: yesno

    - dimension: created
      type: time
      timeframes: [time, date, week, month, year, hour_of_day, day_of_week, week_of_year]
      datatype: epoch
      sql: INTEGER(${TABLE}.created_utc)
      
    - dimension: link_flair_text
      type: string

    - dimension: ups
      type: number

    - dimension: distinguished
      type: string

    - measure: count
      type: count
      drill_fields: detail*

    - measure: comment_count
      type: sum
      sql: ${num_comments}

  sets:
    detail:
      - title
      - author
      - created_time
      - subreddit
      - url

