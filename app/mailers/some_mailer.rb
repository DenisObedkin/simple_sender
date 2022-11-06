class SomeMailer < ApplicationMailer
  def new_email(name, d_begin, d_end, files, email)
    @data = name
    @begin = d_begin
    @end = d_end
    @files = files
    @email = email

    mail(from: 'me@admin.ru', to: @email, subject: "Новое сообщение!")
  end
end