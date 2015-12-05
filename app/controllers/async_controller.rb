class AsyncController < ApplicationController
  def index
    render :index
    send_mail_to_user
  end

  private

  def send_mail_to_user(worker = ::AsyncMailer)
    worker.perform_async
  end
end
