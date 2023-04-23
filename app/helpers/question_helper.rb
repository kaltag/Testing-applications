module QuestionHelper
  def question_header(object, test)
    if object.new_record?
      "Create new #{test.title} question"
    else
      "Edit #{test.title} question"
    end
  end
end
