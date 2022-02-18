# frozen_string_literal: true

class User < ApplicationRecord
  has_many :project_assignments, dependent: :destroy
  has_many :projects, through: :project_assignments
  has_many :bug_assignments, dependent: :destroy
  has_many :bugs, through: :bug_assignments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
