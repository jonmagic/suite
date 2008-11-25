module ChecklistsHelper
  
  def checklist_question_helper(f, question)
    if question.answer_type == "text"
      answer = f.text_area(question.answer_type.to_sym)
    elsif question.answer_type == "boolean"
      answer = f.check_box(question.answer_type.to_sym)
    else
      answer = f.text_field(question.answer_type.to_sym)
    end
  end
  
  def checklist_question_status(question)
    if question.completed == true
      return "complete"
    else
      return ""
    end
  end
  
  def checklist_for_helper(checklist)
    if checklist.device
      return "Checklist for " + checklist.device.service_tag
    elsif checklist.ticket
      return "Checklist: " + checklist.name
    else
      return ""
    end
  end

end
