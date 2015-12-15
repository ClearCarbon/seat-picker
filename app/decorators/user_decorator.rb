class UserDecorator < Draper::Decorator
  delegate_all

  def summary
    "#{username} (#{email})"
  end
end
