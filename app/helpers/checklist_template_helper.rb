module ChecklistTemplateHelper

  def add_question_link(checklist) 
    link_to_function image_tag("/images/icons/add.png") do |page| 
      page.insert_html :bottom, :questions, :partial => 'question', :object => ChecklistTemplateQuestion.new 
    end 
  end

end