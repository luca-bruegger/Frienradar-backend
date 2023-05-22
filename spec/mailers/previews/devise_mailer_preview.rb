# Preview all emails at http://localhost:3000/rails/mailers/devise_mailer

class DeviseMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    DeviseMailer.confirmation_instructions(User.first, "faketoken", {})
  end

end
