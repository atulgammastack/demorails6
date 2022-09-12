class SendmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserMailer.reset_password_instructions(user).deliver
  end
end
