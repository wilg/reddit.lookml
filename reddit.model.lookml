- connection: bigquery_publicdata

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: subreddit
  persist_for: 8760 hour

- explore: post
  persist_for: 8760 hour
  always_filter:
    nsfw: No
  joins:
    - join: subreddit
      relationship: many_to_one
      sql_on: ${post.subreddit_id} = ${subreddit.long_id}

- explore: comment
  persist_for: 8760 hour
  joins:
    - join: post
      relationship: many_to_one
      sql_on: ${comment.post_id} = ${post.long_id}
    - join: subreddit
      relationship: many_to_one
      sql_on: ${post.subreddit_id} = ${subreddit.long_id}
