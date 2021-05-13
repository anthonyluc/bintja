class ApplicationMailer < ActionMailer::Base
  default from: 'Bintja <contact@bintja.com>',
  reply_to: "Bintja <contact@bintja.com>"
  layout 'mailer'
end
