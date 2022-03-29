desc 'drops the db, creates db, migrates db and populates development environment data'

task reset_dev_data: [:environment, 'db:drop', 'db:create', 'db:migrate', 'db:seed'] if Rails.env.development?