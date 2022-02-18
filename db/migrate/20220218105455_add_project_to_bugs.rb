<<<<<<< HEAD
<<<<<<< HEAD
# frozen_string_literal: true

=======
>>>>>>> 14ff5ea (Bugs::Bug and Project Associations)
=======
# frozen_string_literal: true

>>>>>>> 8d7b9f7 (Bugs::Complete Bugs Module)
class AddProjectToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :project, foreign_key: true
  end
end
