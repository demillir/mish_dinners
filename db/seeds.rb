Division.destroy_all

division = Division.create!(abbr: 'div')

pitch = <<-EOS
      Please sign up to provide dinner for the homeless living in this district.
      Include your email address to receive a reminder email two days before the dinner appointment.
      If a dinner slot has a "SACK" watermark, the meal should be a sack dinner delivered to the
      District Shelter.
      <strong>"Thank you so much for your support!"</strong> &hearts;The Homeless
EOS

unit = division.units.create!(abbr:              'un',
                              uuid:              '3f9a82e0-ffad-423d-862f-46141ad26d8d',
                              coordinator_email: 'feedinghomeless@gmail.com',
                              coordinator_name:  'Jane Doe',
                              meal_time:         '<strong>6:00 PM for in-home dinners, 3:00-6:00 PM for sack dinners</strong>',
                              reminder_subject:  '[Volunteer Meal] Sign-up reminder',
                              volunteer_pitch:   pitch)

recip1 = unit.recipients.create!(phone: '555-444-2222')
recip2 = unit.recipients.create!(phone: '555-333-1111')

volunteer1 = unit.volunteers.create!(name: 'Smith', phone: '555-111-2222', email: 'smith@smith.com')
volunteer2 = unit.volunteers.create!(name: 'Jones', phone: '555-222-3333', email: 'jones@jones.com')
volunteer3 = unit.volunteers.create!(name: 'Famly', phone: '555-333-4444', email: 'famly@famly.com')

recip1.meals.create!(date: Date.new(2013, 8, 25), volunteer: volunteer1, type: 'InHome')
recip1.meals.create!(date: Date.new(2013, 8, 26), volunteer: volunteer2, type: 'InHome')
recip1.meals.create!(date: Date.new(2013, 8, 27), volunteer: volunteer3, type: 'Sack'  )
recip1.meals.create!(date: Date.new(2013, 8, 28), volunteer: volunteer1, type: 'InHome')
recip1.meals.create!(date: Date.new(2013, 8, 30), volunteer: volunteer3, type: 'Sack'  )
recip1.meals.create!(date: Date.new(2013, 9,  1), volunteer: volunteer2, type: 'InHome')
recip1.meals.create!(date: Date.new(2013, 9,  2), volunteer: volunteer2, type: 'InHome')

recip2.meals.create!(date: Date.new(2013, 8, 25), volunteer: volunteer2, type: 'InHome')
recip2.meals.create!(date: Date.new(2013, 8, 26), volunteer: volunteer2, type: 'Sack'  )
recip2.meals.create!(date: Date.new(2013, 8, 27), volunteer: volunteer3, type: 'Sack'  )
recip2.meals.create!(date: Date.new(2013, 8, 28), volunteer: volunteer1, type: 'InHome')
recip2.meals.create!(date: Date.new(2013, 8, 29), volunteer: volunteer1, type: 'Sack'  )
recip2.meals.create!(date: Date.new(2013, 8, 30), volunteer: volunteer3, type: 'Sack'  )
