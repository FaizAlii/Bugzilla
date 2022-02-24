# frozen_string_literal: true

module ProjectsHelper
  def roles(user)
    user.roles.pluck(:name).join(', ')
  end
end
