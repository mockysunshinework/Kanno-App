module ApplicationHelper
	# ページごとにタイトルを返す
  def full_title(page_name = "")
    base_title = "Task管理・Task依頼アプリ"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end

  def bootstrap_alert(key)
    case key
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    end
  end
  
end
