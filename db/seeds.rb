# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

org = Organization.create name: 'TestOrg'
head = Head.create email: 'test@org.com', password: 'qweqwe',
                   password_confirmation: 'qweqwe'

user = User.create email: 'user@org.com', password: 'qweqwe',
                   password_confirmation: 'qweqwe'

org.users << user
