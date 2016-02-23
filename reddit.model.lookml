- connection: bigquery_publicdata

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: post
  persist_for: 8760 hour