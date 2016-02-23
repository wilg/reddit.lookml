- view: subreddit
  sql_table_name: "[fh-bigquery:reddit.subreddits_201509]"
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id
    hidden: true
    
  - dimension: long_id
    type: string
    sql: ${TABLE}.name
    hidden: true

  - dimension: banner_img
    type: string
    sql: ${TABLE}.banner_img

  - dimension: collapse_deleted_comments
    type: yesno
    sql: ${TABLE}.collapse_deleted_comments

  - dimension: comment_score_hide_mins
    type: number
    sql: ${TABLE}.comment_score_hide_mins

  - dimension: created
    type: number
    sql: ${TABLE}.created

  - dimension: created_utc
    type: number
    sql: ${TABLE}.created_utc

  - dimension: description
    type: string
    sql: ${TABLE}.description

  - dimension: description_html
    type: string
    sql: ${TABLE}.description_html

  - dimension: display_name
    type: string
    sql: ${TABLE}.display_name

  - dimension: header_img
    type: string
    sql: ${TABLE}.header_img

  - dimension: header_title
    type: string
    sql: ${TABLE}.header_title

  - dimension: hide_ads
    type: yesno
    sql: ${TABLE}.hide_ads

  - dimension: icon_img
    type: string
    sql: ${TABLE}.icon_img

  - dimension: lang
    type: string
    sql: ${TABLE}.lang

  - dimension: over18
    type: yesno
    sql: ${TABLE}.over18

  - dimension: public_description
    type: string
    sql: ${TABLE}.public_description

  - dimension: public_description_html
    type: string
    sql: ${TABLE}.public_description_html

  - dimension: public_traffic
    type: yesno
    sql: ${TABLE}.public_traffic

  - dimension: quarantine
    type: yesno
    sql: ${TABLE}.quarantine

  - dimension: submission_type
    type: string
    sql: ${TABLE}.submission_type

  - dimension: submit_link_label
    type: string
    sql: ${TABLE}.submit_link_label

  - dimension: submit_text
    type: string
    sql: ${TABLE}.submit_text

  - dimension: submit_text_html
    type: string
    sql: ${TABLE}.submit_text_html

  - dimension: submit_text_label
    type: string
    sql: ${TABLE}.submit_text_label

  - dimension: subreddit_type
    type: string
    sql: ${TABLE}.subreddit_type

  - dimension: subscribers
    type: number
    sql: ${TABLE}.subscribers

  - dimension: title
    type: string
    sql: ${TABLE}.title

  - dimension: url
    type: string
    sql: ${TABLE}.url

  - dimension: user_sr_theme_enabled
    type: yesno
    sql: ${TABLE}.user_sr_theme_enabled

  - measure: count
    type: count
    approximate_threshold: 100000
    drill_fields: [id, name, display_name]

