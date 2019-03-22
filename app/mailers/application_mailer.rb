# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'poe.currency.log@gmail.com'
  layout 'mailer'
end
