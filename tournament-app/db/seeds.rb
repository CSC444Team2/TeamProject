# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

t1=Tournament.create(name: 'myTournament')
t2=Tournament.create(name: 'myTournament2')
t3=Tournament.create(name: 'myTournament3')
t4=Tournament.create(name: 'hello4', location: 'Toronto', date: DateTime.new(2016, 12, 12, 12, 0, 0), contact_email: 'abc@abc.com', contact_name: 'corey')


u1=User.new(first_name: 'Alice', last_name: 'Aleena', email: 'aasdf@aasdf.com', 
	password:'1234567', password_confirmation:'1234567')
u1.generate_token(:auth_token)
u1.save
u2=User.create(first_name: 'Ben', last_name: 'Bean', email: 'b@b.com', 
	password:'1234567', password_confirmation:'1234567')
u3=User.create(first_name: 'Cathy', last_name: 'Clark', email: 'c@c.com', 
	password:'1234567', password_confirmation:'1234567')
u4=User.create(first_name: 'Dave', last_name: 'Drive', email: 'd@d.com', 
	password:'1234567', password_confirmation:'1234567')
u5=User.create(first_name: 'Ellen', last_name: 'Elms', email: 'e@e.com', 
	password:'1234567', password_confirmation:'1234567')
u6=User.create(first_name: 'Fox', last_name: 'Findley', email: 'f@f.com', 
	password:'1234567', password_confirmation:'1234567')

g1=GolfCourse.create(name: 'Golf Course 1', overview: 'Great course', address: '123 Main Street', website: 'www.google.com', contact_info: 'Anna')
g2=GolfCourse.create(name: 'Course on Water', overview: 'Water Course', address: '123 Bay Street', website: 'www.baidu.com', contact_info: 'Anna')

r1=Request.create(sender_id: 1, receiver_id: 2)
r2=Request.create(sender_id: 2, receiver_id: 3)

u1.organize_a(t1)
u2.organize_a(t2)
u3.organize_a(t3)
u3.organize_a(t4)

u1.play_in(t1)
u2.play_in(t1)
u3.play_in(t1)
u4.play_in(t1)
u5.play_in(t1)
u2.play_in(t2)
u3.play_in(t3)
u4.play_in(t3)

u1.sponsor_a(t2)
u2.sponsor_a(t4)

pg1=Playergroup.create(tournament_id: t1.id, group_members: [u1.id, u2.id, u3.id, u4.id])
pg2=Playergroup.create(tournament_id: t1.id, group_members: [u5.id])

pg3=Playergroup.create(tournament_id: t3.id, group_members: [u3.id, u4.id, u5.id])

