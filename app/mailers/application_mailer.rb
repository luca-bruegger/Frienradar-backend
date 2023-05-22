# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'support@frienradar.com'
  layout 'mailer'
end
