<<<<<<< HEAD
# frozen_string_literal: true

=======
>>>>>>> 14ff5ea (Bugs::Bug and Project Associations)
class AddProjectToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :project, foreign_key: true
  end
end
