module UsersHelper
  def current_user
    page.evaluate_script 'User.local.id'
  end
end

World(UsersHelper)