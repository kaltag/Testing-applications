Answer.destroy_all
Badge.destroy_all
TestPassage.destroy_all
Gist.destroy_all
Question.destroy_all
Test.destroy_all
Category.destroy_all
Admin.destroy_all
User.destroy_all

c1 = Category.create(title: 'Ruby')
c2 = Category.create(title: 'Rails')
c3 = Category.create(title: 'SQL')

user1 = User.create(email: 'user@test.com', password: '123456', confirmed_at: DateTime.now)
user2 = User.create(email: 'user2@test.com', password: '123456', confirmed_at: DateTime.now)

admin = Admin.create!(
  email: 'admin@test.com',
  password: 123_456,
  first_name: 'Admin',
  last_name: 'Admin',
  confirmed_at: DateTime.now
)

t1 = Test.create(title: 'Lesson 1', level: 1, category_id: c1.id, user_id: user1.id, published: true, timer: 1)
t2 = Test.create(title: 'Lesson 2', level: 10, category_id: c1.id, user_id: user1.id, published: true, timer: 10)
t3 = Test.create(title: 'Lesson 3', level: rand(1..10), category_id: c2.id, user_id: user1.id, published: true)
t4 = Test.create(title: 'Lesson 4', level: rand(1..10), category_id: c2.id, user_id: user2.id, published: true)
t5 = Test.create(title: 'Lesson 5', level: rand(1..10), category_id: c3.id, user_id: user2.id, published: true)
Test.create(title: 'Lesson 6', level: rand(1..10), category_id: c3.id, user_id: user2.id)

TestPassage.create(user: user1, test: t1)
TestPassage.create(user: user2, test: t3)
TestPassage.create(user: user1, test: t2)

q1 = Question.create(body: 'q1', test_id: t1.id)
q2 = Question.create(body: 'q2', test_id: t2.id)
q3 = Question.create(body: 'q2', test_id: t3.id)
q4 = Question.create(body: 'q2', test_id: t4.id)
q5 = Question.create(body: 'q2', test_id: t5.id)

Answer.create(body: 'Uncorrect', question_id: q1.id)
Answer.create(body: 'Correct', correct: true, question_id: q1.id)
Answer.create(body: 'Correct', correct: true, question_id: q2.id)
Answer.create(body: 'Uncorrect', question_id: q2.id)
Answer.create(body: 'Uncorrect', question_id: q3.id)
Answer.create(body: 'Correct', correct: true, question_id: q3.id)
Answer.create(body: 'Uncorrect', question_id: q4.id)
Answer.create(body: 'Correct', correct: true, question_id: q4.id)
Answer.create(body: 'Uncorrect', question_id: q5.id)
Answer.create(body: 'Correct', correct: true, question_id: q5.id)

Badge.create(name: 'All Ruby', rule: 'category', rule_value: 'Ruby')
Badge.create(name: 'All Rails', rule: 'category', rule_value: 'Rails')
Badge.create(name: 'All 10 lvl', rule: 'lvl_tests', rule_value: '10')
Badge.create(name: 'All 1 lvl', rule: 'lvl_tests', rule_value: '1')
Badge.create(name: 'First try', rule: 'first_attempt', rule_value: 'First try')
