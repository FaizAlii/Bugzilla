# frozen_string_literal: true

Role.destroy_all

Role.create!([{ name: 'Manager' }, { name: 'QA' }, { name: 'Developer' }])

Rails.logger.debug '3 Roles created successfully!'

Project.destroy_all
User.destroy_all

user1 = User.new(
  name: 'Faiz Ali',
  email: 'faizz.ali@devsinc.com',
  password: 'faizali',
  password_confirmation: 'faizali',
  role_ids: [25]
)
user1.skip_confirmation!
user1.save!

user2 = User.new(
  name: 'Faiz',
  email: 'faiz.ali@devsinc.com',
  password: 'faizali',
  password_confirmation: 'faizali',
  role_ids: [26]
)
user2.skip_confirmation!
user2.save!

user3 = User.new(
  name: 'Faizz',
  email: 'faizalidecco264@gmail.com',
  password: 'faizali',
  password_confirmation: 'faizali',
  role_ids: [27]
)
user3.skip_confirmation!
user3.save!

Rails.logger.debug '3 Users created successfully!'
