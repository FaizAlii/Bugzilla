# frozen_string_literal: true

Role.destroy_all

Role.create!([{ name: 'Manager' }, { name: 'QA' }, { name: 'Developer' }])

Rails.logger.debug '3 Roles created successfully!'

User.destroy_all

user1 = User.new(
  name: 'Faiz Ali',
  email: 'faizz.ali@devsinc.com',
  password: 'faizali',
  password_confirmation: 'faizali'
)
user1.skip_confirmation!
user1.save!
user1.roles = []
user1.add_role('Manager')

user2 = User.new(
  name: 'Faiz',
  email: 'faiz.ali@devsinc.com',
  password: 'faizali',
  password_confirmation: 'faizali'
)
user2.skip_confirmation!
user2.save!
user2.roles = []
user2.add_role('QA')

user3 = User.new(
  name: 'Faizz',
  email: 'faizalidecco264@gmail.com',
  password: 'faizali',
  password_confirmation: 'faizali'
)
user3.skip_confirmation!
user3.save!
user3.roles = []
user3.add_role('Developer')

Rails.logger.debug '3 Users created successfully!'
