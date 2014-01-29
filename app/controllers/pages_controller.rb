class PagesController < ApplicationController
  def landing
  end

  def business_landing
  end

  def dispatch_email
    user_info = params[:user_info]

    if ContactMailer.send_email(user_info).deliver
      flash[:notice] = "Message Sent! We'll be in touch as soon as possible!"
    else
      flash[:notice] = "Oops - something went wrong! Please try again"
    end

    redirect_to current_path
  end
end
