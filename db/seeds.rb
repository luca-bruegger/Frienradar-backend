# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each { |f| require f }

require 'faker'

#UserSeeds.generate
GeolocationSeeds.generate
