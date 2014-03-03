module TownCrier
  class SampleMailer < ActionMailer::Base
    default from: "txt@spiceworks.com"

    def sample_mail(mail_options)
      @message_text = mail_options.delete(:text)
      @contact = mail_options[:contact]
      mail_options.reverse_merge!({to: @contact.email, subject: 'Sample Message from Town Crier'})
      mail(mail_options)
    end
  end
end
