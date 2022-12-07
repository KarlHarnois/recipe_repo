module ApplicationHelper
  def switch_theme_path
    root_path(theme: cookies[:theme] == 'dark' ? 'light' : 'dark')
  end
end
