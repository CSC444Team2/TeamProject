# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

g1=GolfCourse.create(name: 'Ladies Golf Club of Toronto', overview: 'Great course', address: '7859 Yonge Street, Thornhill, ON L3T 2C4', website: 'http://www.ladiesgolfclub.com/', contact_info: 'Anna')
g2=GolfCourse.create(name: 'Humber Valley Golf Course', address: '40 Beattie Avenue', website: 'http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=5e1cd49024561410VgnVCM10000071d60f89RCRD', contact_info: 'Anna', overview: "Humber Valley's par 70 course challenges golfers with its combination of links and valley land holes.")

t1=Tournament.create(name: 'myTournament', is_private: 0, golf_course_id: 1)
t2=Tournament.create(name: 'myTournament2', is_private: 0, location: 'Buttonville')
t3=Tournament.create(name: 'myTournament3', is_private: 0, golf_course_id: 2)
t5=Tournament.create(name: 'privateTournament', is_private: 1, golf_course_id: 2)
t4=Tournament.create(name: 'hello5', is_private: 0, location: 'Toronto', date: DateTime.new(2016, 12, 12, 12, 0, 0), contact_email: 'abc@abc.com', contact_name: 'corey')


u1=User.create(first_name: 'Alice', last_name: 'Aleena', email: 'aasdf@aasdf.com', 
	password:'1234567', password_confirmation:'1234567')
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

r1=Request.create(sender_id: 1, receiver_id: 2)
r2=Request.create(sender_id: 2, receiver_id: 3)
r2=Request.create(sender_id: 3, receiver_id: 4)
r2=Request.create(sender_id: 4, receiver_id: 1)

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

