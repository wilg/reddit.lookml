- connection: bigquery_publicdata

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: post
  persist_for: 8760 hour
  
- explore: comment
  persist_for: 8760 hour
  joins:
    - join: post
      relationship: many_to_one
      sql_on: ${post.long_id} = ${comment.post_id}
