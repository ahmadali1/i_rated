# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Actor.find_or_create_by(name: "Umas", country: "pakistan")
Actor.find_or_create_by(name: "Umar", country: "pakistan")
Actor.find_or_create_by(name: "Umat", country: "pakistan")
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')