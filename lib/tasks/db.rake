# frozen_string_literal: true

desc "Run too bootstrap the db"
task bootstrap: ['db:create', 'db:schema:load', 'db:migrate']
