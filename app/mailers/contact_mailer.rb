class ContactMailer < ActionMailer::Base

  attr_accessor :name, :email, :message

  default to: "info@vetrify.com",
          from: "info@vetrify.com"

  headers = {'Return-Path' => 'info@vetrify.com'}

  def send_email(params)
    from    = params["from"].present? ?  params["from"] : "info@vetrify.com"
    subject = params["subject"].present? ? params["subject"] : "Lander Page Email"


    mail(
      to: "info@vetrify.com",
      subject: subject,
      from: from,
      return_path: "info@vetrify.com",
      date: Time.now,
      content_type: "text/html"
    )
  end
end
