require 'rails_helper'

RSpec.describe MailerData, :type => :model do
  include Rack::Test::Methods
  include ActionDispatch::TestProcess::FixtureFile

  subject {
    described_class.new(name: "Anything",
                        date_begin: DateTime.now,
                        date_end: DateTime.now + 1.week,
                        files: file,
                        email: 'abc@def.ru')
  }

  let(:file) { [fixture_file_upload('1.jpg')] }
  let(:additional_files) {
    [
      fixture_file_upload('2.png'),
      fixture_file_upload('3.pdf'),
      fixture_file_upload('4.xml'),
      fixture_file_upload('5.jpg'),
      fixture_file_upload('6.jpg')
    ]
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a files" do
    subject.files = []
    expect(subject).to_not be_valid
  end

  it "is not valid if files count more than 5" do
    subject.files = subject.files + additional_files
    expect(subject).to_not be_valid
  end

  it "is not valid without a name" do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it "is not valid without a date_begin" do
    subject.date_begin = ''
    expect(subject).to_not be_valid
  end

  it "is not valid without a date_end" do
    subject.date_end = ''
    expect(subject).to_not be_valid
  end

  it "is not valid if date_end less than date_begin" do
    subject.date_begin = Date.current + 1.day
    subject.date_end = Date.current
    expect(subject).to_not be_valid
  end

  it "is not valid without a email" do
    subject.email = ''
    expect(subject).to_not be_valid
  end
end