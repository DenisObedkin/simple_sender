module Sending
  class UploadFile
    class << self
      def call(files)
        files_dir = Rails.root.join('public', 'uploads')
        Dir.mkdir(files_dir) unless Dir.exists?(files_dir)

        files.each do |u_file|
          File.open(Rails.root.join('public', 'uploads', u_file.original_filename), 'wb') do |file|
            file.write(u_file.read)
          end
        end
      end
    end
  end
end