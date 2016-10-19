# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Tournament.create(name: 'myTournament')
Tournament.create(name: 'myTournament1')
Tournament.create(name: 'myTournament2')

User.create(first_name: 'aasdfadf', last_name: 'a', email: 'aasdf@aasdf.com', 
	password:'1234567', password_confirmation:'1234567')
User.create(first_name: 'b', last_name: 'b', email: 'b@b.com', 
	password:'1234567', password_confirmation:'1234567')
User.create(first_name: 'c', last_name: 'c', email: 'c@c.com', 
	password:'1234567', password_confirmation:'1234567')
