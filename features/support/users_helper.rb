module UsersHelper
  def current_user
    page.evaluate_script 'User.local.id'
  end

  def my_hand
    find(selector_for('my hand'))
  end

end

World(UsersHelper)
