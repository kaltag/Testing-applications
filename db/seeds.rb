User.destroy_all
Answer.destroy_all
Question.destroy_all
Test.destroy_all
Category.destroy_all

c1 = Category.create(title: 'Ruby')
c2 = Category.create(title: 'Rails')
c3 = Category.create(title: 'SQL')

t1 = Test.create(title: 'Lesson 1', level: 0, category_id: c1.id)
t2 = Test.create(title: 'Lesson 2', level: 1, category_id: c1.id)
Test.create(title: 'Lesson 3', level: 1, category_id: c2.id)
Test.create(title: 'Lesson 5', level: 2, category_id: c3.id)

q1 = Question.create(body: 'q1', test_id: t1.id)
q2 = Question.create(body: 'q2', test_id: t2.id)

Answer.create(body: 'Uncorrect', question_id: q1.id)
Answer.create(body: 'Correct', correct: true, question_id: q1.id)
Answer.create(body: 'Correct', correct: true, question_id: q2.id)
Answer.create(body: 'Uncorrect', question_id: q2.id)

User.create(name: 'User')
