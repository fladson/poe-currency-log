module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then "bg-blue-lightest border-blue"
    when 'success' then "bg-green-lightest border-green"
    when 'error' then "bg-red-lightest border-red"
    when 'alert' then "bg-orange-lightest border-orange"
    end
  end
end
