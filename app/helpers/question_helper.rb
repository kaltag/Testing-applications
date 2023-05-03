module QuestionHelper
  def question_header(object)
    if object.new_record?
      t('admin.questions.new.header', test_title: object.test.title)
    else
      t('admin.questions.edit.header', test_title: object.test.title)
    end
  end
end
