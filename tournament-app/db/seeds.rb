# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

g1=GolfCourse.create(name: 'course1', overview: 'Great course', address: '123 Main Street', website: 'www.google.com', contact_info: 'Anna')
g2=GolfCourse.create(name: 'water', overview: 'Water Course', address: '123 Bay Street', website: 'www.baidu.com', contact_info: 'Anna')

t1=Tournament.create(name: 'myTournament')
t2=Tournament.create(name: 'myTournament2')
t3=Tournament.create(name: 'myTournament3')
t4=Tournament.create(name: 'hello4', location: 'Toronto', date: DateTime.new(2016, 12, 12, 12, 0, 0), contact_email: 'abc@abc.com', contact_name: 'corey')

u1=User.create(first_name: 'aasdfadf', last_name: 'a', email: 'aasdf@aasdf.com', 
	password:'1234567', password_confirmation:'1234567')
u2=User.create(first_name: 'b', last_name: 'b', email: 'b@b.com', 
	password:'1234567', password_confirmation:'1234567')
u3=User.create(first_name: 'c', last_name: 'c', email: 'c@c.com', 
	password:'1234567', password_confirmation:'1234567')

u1.organize_a(t1)
u2.organize_a(t2)
u3.organize_a(t3)
u3.organize_a(t4)

r1=Request.create(sender_id: 1, receiver_id: 2)
r2=Request.create(sender_id: 2, receiver_id: 3)


