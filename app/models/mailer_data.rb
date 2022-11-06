class MailerData
  include ActiveModel::Model

  attr_accessor :name, :date_begin, :date_end, :email, :files

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :date_begin, :date_end, :email, presence: { message: 'Поле не может быть пустым' }
  validates :email, format: { with: VALID_EMAIL_REGEX, message: 'Неверный формат email' }

  validate :comparison_dates
  validate :check_files_quantity

  private

  def comparison_dates
    return false unless date_end.present? && date_begin.present?

    if date_end < date_begin
      errors.add('date_end', 'Дата окончания д. б. больше даты начала')
    end
  end

  def check_files_quantity
    unless files&.size.in?(1..5)
      errors.add('files', 'Кол-во загружаемых файлов д. б. от 1 до 5')
    end
  end
end