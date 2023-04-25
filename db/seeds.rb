Answer.destroy_all
Question.destroy_all
TestPassage.destroy_all
Test.destroy_all
Category.destroy_all
User.destroy_all

c1 = Category.create(title: 'Ruby')
c2 = Category.create(title: 'Rails')
c3 = Category.create(title: 'SQL')

user1 = User.create(name: Faker::Name.first_name)
user2 = User.create(name: Faker::Name.first_name)

t1 = Test.create(title: 'Lesson 1', level: rand(1..10), category_id: c1.id, user_id: user1.id)
t2 = Test.create(title: 'Lesson 2', level: rand(1..10), category_id: c1.id, user_id: user1.id)
t3 = Test.create(title: 'Lesson 3', level: rand(1..10), category_id: c2.id, user_id: user1.id)
Test.create(title: 'Lesson 4', level: rand(1..10), category_id: c2.id, user_id: user2.id)
Test.create(title: 'Lesson 5', level: rand(1..10), category_id: c3.id, user_id: user2.id)
Test.create(title: 'Lesson 6', level: rand(1..10), category_id: c3.id, user_id: user2.id)

TestPassage.create(user: user1, test: t1)
TestPassage.create(user: user2, test: t3)
TestPassage.create(user: user1, test: t2)

q1 = Question.create(body: 'q1', test_id: t1.id)
q2 = Question.create(body: 'q2', test_id: t2.id)

Answer.create(body: 'Uncorrect', question_id: q1.id)
Answer.create(body: 'Correct', correct: true, question_id: q1.id)
Answer.create(body: 'Correct', correct: true, question_id: q2.id)
Answer.create(body: 'Uncorrect', question_id: q2.id)
