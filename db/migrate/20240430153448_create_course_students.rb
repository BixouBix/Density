class CreateCourseStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :course_students do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: true
      t.integer :year
      t.integer :q1
      t.integer :q2
      t.integer :q3
      t.integer :q4

      t.timestamps
    end
  end
end
