# frozen_string_literal: true

class User < ApplicationRecord
  rolify

  has_many :project_assignments, dependent: :destroy
  has_many :projects, through: :project_assignments
  has_many :bug_assignments, dependent: :destroy
  has_many :bugs, through: :bug_assignments

  has_and_belongs_to_many :roles, join_table: :users_roles
  accepts_nested_attributes_for :roles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, :email, presence: true, length: { maximum: 255 }
  validates :email, uniqueness: true, format: Devise.email_regexp
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  # validates :roles, presence: true
  # validate :user_must_select_atleast_one_role

  # def user_must_select_atleast_one_role
  #   errors.add(:role, 'You must select at least one role') if role_ids.empty?
  # end
end
