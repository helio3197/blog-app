module UsersHelper
  def users_index?
    current_page?(users_path) || current_page?(root_path)
  end
end
