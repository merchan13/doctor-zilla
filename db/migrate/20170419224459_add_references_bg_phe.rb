class AddReferencesBgPhe < ActiveRecord::Migration[5.0]
  def change
    add_reference :backgrounds, :consultation, foreign_key: true
    add_reference :physical_exams, :consultation, foreign_key: true
  end
end
