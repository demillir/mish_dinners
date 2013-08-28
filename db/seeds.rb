Division.destroy_all

division = Division.create!(abbr: 'lo')

pitch = <<-EOS
      Please sign up to provide dinner for the missionaries serving in the Lake Oswego Ward.
      You may sign up for one or both companionships on the same evening.
      Include your email address to receive a reminder email two days before the dinner appointment.
      If a dinner slot has a "SACK" watermark, the meal should be a sack dinner delivered to the
      Portland Temple Visitors' Center.
      "Thank you so much for your support!" --The Sisters
EOS

unit = division.units.create!(abbr:              'lo',
                              uuid:              '1bd97844-2bb1-4046-bbe8-d63f6411af46',
                              coordinator_email: 'LOmissionarymeals@gmail.com',
                              meal_time:         '6pm for dinner in your home, 3-6pm for sack dinners',
                              volunteer_pitch:   pitch)

companionship1 = unit.recipients.create!(phone: '503-490-3314')
companionship2 = unit.recipients.create!(phone: '503-608-8858')

aug25 = unit.days.create!(date: Date.new(2013, 8, 25))
aug26 = unit.days.create!(date: Date.new(2013, 8, 26))
aug27 = unit.days.create!(date: Date.new(2013, 8, 27))
aug28 = unit.days.create!(date: Date.new(2013, 8, 28))
aug29 = unit.days.create!(date: Date.new(2013, 8, 29))
aug30 = unit.days.create!(date: Date.new(2013, 8, 30))
aug31 = unit.days.create!(date: Date.new(2013, 8, 31))

sep01 = unit.days.create!(date: Date.new(2013, 9, 1))
sep02 = unit.days.create!(date: Date.new(2013, 9, 2))
sep03 = unit.days.create!(date: Date.new(2013, 9, 3))
sep04 = unit.days.create!(date: Date.new(2013, 9, 4))
sep05 = unit.days.create!(date: Date.new(2013, 9, 5))
sep06 = unit.days.create!(date: Date.new(2013, 9, 6))
sep07 = unit.days.create!(date: Date.new(2013, 9, 7))
sep08 = unit.days.create!(date: Date.new(2013, 9, 8))

aug25.appointments.create!(recipient: companionship1, name: 'Leuenberger', phone: '503-303-8071')
aug25.appointments.create!(recipient: companionship2, css_class: 'sack')

aug26.appointments.create!(recipient: companionship1, name: 'Madsen', phone: '503-624-5809')
aug26.appointments.create!(recipient: companionship2, name: 'Madsen', phone: '503-624-5809')

aug27.appointments.create!(recipient: companionship1, name: 'Doty', phone: '971-275-7207')
aug27.appointments.create!(recipient: companionship2, name: 'Doty', phone: '971-275-7207')

aug28.appointments.create!(recipient: companionship1, name: 'Starke', phone: '503-313-9624', css_class: 'sack')
aug28.appointments.create!(recipient: companionship2, name: 'Starke', phone: '503-313-9624', css_class: 'sack')

aug29.appointments.create!(recipient: companionship1, name: 'Tuttle', phone: '503-201-3959')
aug29.appointments.create!(recipient: companionship2, css_class: 'sack')

aug30.appointments.create!(recipient: companionship1, css_class: 'sack')

sep01.appointments.create!(recipient: companionship2, css_class: 'sack')

sep02.appointments.create!(recipient: companionship1, css_class: 'sack')
sep02.appointments.create!(recipient: companionship2, css_class: 'sack')

sep04.appointments.create!(recipient: companionship1, css_class: 'sack')
sep04.appointments.create!(recipient: companionship2, css_class: 'sack')

sep05.appointments.create!(recipient: companionship2, css_class: 'sack')

sep06.appointments.create!(recipient: companionship1, css_class: 'sack')

sep08.appointments.create!(recipient: companionship2, css_class: 'sack')
