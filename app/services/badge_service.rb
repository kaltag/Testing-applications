class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = @test_passage.user
    @test = @test_passage.test
  end

  def give_badge
    Badge.all.each do |badge|
      create_badge(badge) if send(badge.rule.to_s, badge.rule_value)
    end
  end

  def create_badge(badge)
    @user.badges << badge
  end

  private

  def first_attempt(_rule_value)
    @user.test_passages.where(test_id: @test.id).count == 1
  end

  def lvl_tests(rule_value)
    return false if rule_value.to_i != @test_passage.test.level

    all_tests_id = Test.where(level: rule_value.to_i).published.order(:id).pluck(:id)
    user_tests_ids = user_tests_by_level(rule_value.to_i).order(:test_id).pluck(:test_id).uniq
    user_tests_ids.present? && user_tests_ids == all_tests_id
  end

  def category(rule_value)
    user_category_tests_ids = user_tests_by_category.order(:test_id).pluck(:test_id).uniq
    all_category_tests_id = Test.get_tests_category(rule_value).where(published: true).order(:id).pluck(:id)
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
