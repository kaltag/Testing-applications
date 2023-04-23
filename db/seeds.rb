Answer.destroy_all
Question.destroy_all
UserTest.destroy_all
Test.destroy_all
Category.destroy_all
User.destroy_all

15.times { Category.create(title: Faker::ProgrammingLanguage.name) }
10.times { User.create(name: Faker::Name.first_name) }

20.times do
  Test.create(title: Faker::Hacker.adjective,
              level: rand(1..10),
              category_id: Category.find(Category.ids.sample).id,
              user_id: User.find(User.ids.sample).id)
end
10.times { UserTest.create(user: User.find(User.ids.sample), test: Test.find(Test.ids.sample)) }
100.times { Question.create(body: Faker::Lorem.sentence, test_id: Test.find(Test.ids.sample).id) }

Question.all.each do |question|
  Answer.create(body: 'Correct', correct: true, question_id: question.id)
  Answer.create(body: 'Uncorrect', question_id: question.id)
  Answer.create(body: 'Uncorrect', question_id: question.id)
  Answer.create(body: 'Uncorrect', question_id: question.id)
end
