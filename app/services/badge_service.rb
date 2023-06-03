class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = @test_passage.user
    @test = @test_passage.test
  end

  def give_badge
    Badge.all.each do |badge|
      create_badge(badge) if send(badge.rule.to_s)
    end
  end

  def create_badge(badge)
    UserReward.create(user: @user, badge:)
  end

  private

  def first_attempt
    @user.test_passages.where(test_id: @test.id).count == 1
  end

  def easy_tests
    user_easy_tests_ids = user_tests_by_easy_level.pluck(:test_id).uniq.sort
    all_easy_tests_id = Test.easy_tests.where(published: true).pluck(:id).sort
    user_easy_tests_ids.present? && user_easy_tests_ids == all_easy_tests_id
  end

  def medium_tests
    user_medium_tests_ids = user_tests_by_medium_level.pluck(:test_id).uniq.sort
    all_medium_tests_id = Test.medium_tests.where(published: true).pluck(:id).sort
    user_medium_tests_ids.present? && user_medium_tests_ids == all_medium_tests_id
  end

  def hard_tests
    user_hard_tests_ids = user_tests_by_hard_level.pluck(:test_id).uniq.sort
    all_hard_tests_id = Test.hard_tests.where(published: true).pluck(:id).sort
    user_hard_tests_ids.present? && user_hard_tests_ids == all_hard_tests_id
  end

  def category_complete
    user_category_tests_ids = user_tests_by_category.pluck(:test_id).uniq.sort
    all_category_tests_id = Test.get_tests_category(@test.category.title).where(published: true).pluck(:id).sort
    user_category_tests_ids.present? && user_category_tests_ids == all_category_tests_id
  end

  def user_tests_by_easy_level
    TestPassage.includes(:user, :test).where(user: @user).where(success: true).where(tests: { level: 0..1 })
  end

  def user_tests_by_medium_level
    TestPassage.includes(:user, :test).where(user: @user).where(success: true).where(tests: { level: 2..4 })
  end

  def user_tests_by_hard_level
    TestPassage.includes(:user, :test).where(user: @user).where(success: true).where(tests: { level: 5..Float::INFINITY })
  end

  def user_tests_by_category
    TestPassage.includes(:user, test: [:category])
               .where(user: @user)
               .where(success: true)
               .where(tests: { categories: { id: @test.category.id } })
  end
end
