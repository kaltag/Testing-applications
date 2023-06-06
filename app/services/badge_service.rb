class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = @test_passage.user
    @test = @test_passage.test
    @easy_lvl = 0..1
    @medium_lvl = 2..4
    @hard_lvl = 5..Float::INFINITY
  end

  def give_badge
    Badge.all.each do |badge|
      create_badge(badge) if send(badge.rule.to_s)
    end
  end

  def create_badge(badge)
    @user.badges << badge
  end

  private

  def first_attempt
    @user.test_passages.where(test_id: @test.id).count == 1
  end

  def easy_tests
    user_easy_tests_ids = user_tests_by_level(@easy_lvl).order(:test_id).pluck(:test_id).uniq
    all_easy_tests_id = Test.easy_tests.published.order(:id).pluck(:id)
    user_easy_tests_ids.present? && user_easy_tests_ids == all_easy_tests_id unless @user.badges.where(rule: 'easy_tests').present?
  end

  def medium_tests
    user_medium_tests_ids = user_tests_by_level(@medium_lvl).order(:test_id).pluck(:test_id).uniq
    all_medium_tests_id = Test.medium_tests.published.order(:id).pluck(:id)
    user_medium_tests_ids.present? && user_medium_tests_ids == all_medium_tests_id unless @user.badges.where(rule: 'medium_tests').present?
  end

  def hard_tests
    user_hard_tests_ids = user_tests_by_level(@hard_lvl).order(:test_id).pluck(:test_id).uniq
    all_hard_tests_id = Test.hard_tests.published.order(:id).pluck(:id)
    user_hard_tests_ids.present? && user_hard_tests_ids == all_hard_tests_id unless @user.badges.where(rule: 'hard_tests').present?
  end

  def category_ruby
    user_category_tests_ids = user_tests_by_category.order(:test_id).pluck(:test_id).uniq
    all_category_tests_id = Test.get_tests_category('Ruby').where(published: true).order(:id).pluck(:id)
    user_category_tests_ids.present? && user_category_tests_ids == all_category_tests_id
  end

  def user_tests_by_level(lvl)
    TestPassage.includes(:test).where(user: @user).where(success: true).where(tests: { level: lvl })
  end

  def user_tests_by_category
    TestPassage.includes(test: [:category])
               .where(user: @user)
               .where(success: true)
               .where(tests: { categories: { id: @test.category.id } })
  end
end
