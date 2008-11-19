class CreateChecklistTemplateQuestions < ActiveRecord::Migration
  def self.up
    create_table  :checklist_template_questions do |t|
      t.integer   :checklist_template_id
      t.string    :answer_type
      t.text      :question

      t.timestamps
    end
  end

  def self.down
    drop_table :checklist_template_questions
  end
end
