class User < ApplicationRecord
  has_and_belongs_to_many :tests
  # я не смог придумать как без ассоциаций и общей таблицы сохранять тесты которые проходил юзер. Так же я добавил в параметры самого юзера,
  # тк у нас еще нет девайса и @current.user если смотреть для текущего пользователя
  def method_name(user, level)
    user.tests.where(level:)
  end
end
