class ApplicationMailer < ActionMailer::Base
  add_template_helper(TasksHelper)
  default from: "taskel@test.com"
  layout 'mailer'
end
