module CohesiveAdmin
  class LoginNotifier < ApplicationMailer
    default from: "noreply@yourwebsite.com"

    layout 'cohesive_admin/mailer'

    def password_reset(user, password)
      @password = password
      mail(to: user.email, subject: "Cohesive Admin // Password Reset")
    end
  end
end
