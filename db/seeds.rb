# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


head = Head.new email: 'test@org.com', password: 'qweqwe',
                   password_confirmation: 'qweqwe'
head.organizations.new name: 'TestOrg'
head.save!

org = head.organizations.first
org.users.create email: 'user@org.com', password: 'qweqwe',
                 password_confirmation: 'qweqwe', role: :users
org.save!
