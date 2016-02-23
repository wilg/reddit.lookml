- view: post
  extends: sentiment_analysis
#   sql_table_name: "[fh-bigquery:reddit_posts.full_corpus_201512]"
  derived_table:
    sql: |
      select * from [fh-bigquery:reddit_posts.full_corpus_201512] as post
      where 
        (((INTEGER(post.created_utc)) >= (TIMESTAMP_TO_SEC(TIMESTAMP(TIMESTAMP('2015-10-01')))) AND (INTEGER(post.created_utc)) < (TIMESTAMP_TO_SEC(TIMESTAMP(DATE_ADD(TIMESTAMP('2015-10-01'), 1, 'MONTH'))))))
      limit 100000
    persist_for: 3600 hours

  fields:

    - dimension: id
      type: string
      primary_key: true
      links:
        - label: View Post
          url: https://reddit.com/{{value}}
          icon_url: https://www.reddit.com/favicon.ico
        - label: View Link
          url: "{{ post.url._value }}"
          icon_url: https://www.reddit.com/favicon.ico

    - dimension: long_id
      type: string
      sql: ${TABLE}.name

    - dimension: author
      type: string
      links:
        - label: /u/{{value}}
          url: https://reddit.com/user/{{value}}
          icon_url: https://www.reddit.com/favicon.ico

    - dimension: domain
      type: string
      sql: |
        CASE WHEN ${TABLE}.is_self THEN NULL ELSE ${TABLE}.domain END
      links:
        - label: View Domain
          url: http://{{value}}
          icon_url: http://{{value}}/favicon.ico

    - dimension: subreddit
      type: string
      links:
        - label: /r/{{value}}
          url: https://www.reddit.com/r/{{value}}
          icon_url: https://www.reddit.com/favicon.ico
      drill_fields: [author, nsfw, self_post, title]
          
    - dimension: body
      sql: CONCAT(${title}, ' ', ${selftext})

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
      drill_fields: [id]

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
      sql: ${TABLE}.is_self OR ${url} = 'self'

    - dimension: from_id
      type: string

#     - dimension: permalink
#       type: string

    - dimension: url
      type: string
      
    - dimension: image_file_extension
      sql: REGEXP_EXTRACT(LOWER(${url}), r'(jpg|jpeg|gif|png|gifv)$')
      
    - dimension: is_image
      type: yesno
      sql: |
        ${domain} CONTAINS 'imgur.com' OR
        ${domain} CONTAINS 'imgflip.com' OR
        ${domain} CONTAINS 'gfycat.com' OR
        ${domain} CONTAINS 'twimg.com' OR
        ${image_file_extension} IS NOT NULL
        
    - dimension: is_external_link
      type: yesno
      sql: NOT (${domain} CONTAINS 'reddit.com')

    - dimension: author_flair_text
      type: string

    - dimension: quarantine
      type: yesno

    - dimension: created
      type: time
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
      drill_fields: detail*

    - measure: average_score
      type: average
      sql: ${score}
      decimals: 1
      drill_fields: detail*

  sets:
    detail:
      - id
      - score
      - title
      - author
      - created_time
      - subreddit

