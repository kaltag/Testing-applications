module QuestionHelper
  def question_header(object)
    if object.new_record?
      "Create new #{object.test.title} question"
    else
      "Edit #{object.test.title} question"
    end
  end
end
