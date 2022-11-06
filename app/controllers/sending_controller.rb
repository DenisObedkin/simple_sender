class SendingController < ApplicationController
  def index; end
  
  def send_mail
    @data = MailerData.new(mailer_params)

    if @data.valid?
      ::Sending::UploadFile.(params[:mailer_data][:files]) if params[:mailer_data][:files].present?
      SomeMailer.new_email(
        params[:mailer_data][:name],
        params[:mailer_data][:date_begin],
        params[:mailer_data][:date_end],
        files_paths,
        params[:mailer_data][:email]
      ).deliver_later

      render :success
    end
  end

  private

  def mailer_params
    params.require(:mailer_data)
      .permit(:name, :date_begin, :date_end, :email, files: [])
  end

  def files_paths
    {}.tap do |items|
      params[:mailer_data][:files].each do |file|
        items[file.original_filename] = "#{request.base_url}/uploads/#{file.original_filename}"
      end
    end
  end
end
