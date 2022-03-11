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
  role_ids: [1]
)
user1.skip_confirmation!
user1.save!

user2 = User.new(
  name: 'Faiz',
  email: 'faiz.ali@devsinc.com',
  password: 'faizali',
  password_confirmation: 'faizali',
  role_ids: [2]
)
user2.skip_confirmation!
user2.save!

user3 = User.new(
  name: 'Faizz',
  email: 'faizalidecco264@gmail.com',
  password: 'faizali',
  password_confirmation: 'faizali',
  role_ids: [3]
)
user3.skip_confirmation!
user3.save!

Rails.logger.debug '3 Users created successfully!'

project1 = user1.projects.new(
  name: 'Project 1',
  description: 'This is a new Project.'
)

project1.project_assignments.build(user: user1)
project1.save!

project2 = user1.projects.new(
  name: 'Project 2',
  description: 'This is also a new Project.'
)

project2.project_assignments.build(user: user1)
project2.save!

ProjectAssignment.create!(
  user_id: user3.id,
  project_id: project1.id
)

Bug.destroy_all

bug1 = project1.bugs.create!(
  title: 'New Bug',
  description: 'This is a new bug.',
  deadline: Date.tomorrow.in_time_zone.change(hour: 11),
  bug_type: 'bug',
  status: 'new',
  user_id: user2.id
)

bug1.dev_id = user3.id
bug1.save!

project2.bugs.create!(
  title: 'New Bug on Project 2',
  description: 'This is a new bug on Project 2.',
  deadline: Date.tomorrow.in_time_zone.change(hour: 11),
  bug_type: 'feature',
  status: 'new',
  user_id: user2.id
)
