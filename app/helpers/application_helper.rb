# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice'  then 'bg-blue-lightest border-blue'
    when 'success' then 'bg-green-lightest border-green'
    when 'error'   then 'bg-red-lightest border-red'
    when 'alert'   then 'bg-orange-lightest border-orange'
    end
  end

  def active_class?(league)
    request.path == "/dashboard/#{league.parameterize}" ? 'font-bold' : ''
  end

  def deparametrize(str)
    str.split('-').join(' ')
  end
end
