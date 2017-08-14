  Wiki.destroy_all
  Collaborator.destroy_all
  ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'wikis'")
  ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'collaborators'")
