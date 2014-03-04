require 'xmpp4r-simple'

module TownCrier
  ##
  # A Medium is just a Class/static object for transmittal
  # subclasses handle the delivery of Messages
  class Medium
    def self.get_type(name)
      TownCrier.const_get(name.to_s.camelize, false)
    end

    def self.to_s
      name.demodulize
    end

    def self.available
      available = []
      available << :sms << :email if email?
      available << :mobile_push if mobile_push?
      available << :instant_message if instant_messenger?
      available
    end

    # checks if an email address is configured
    def self.email?
      ActionMailer::Base.smtp_settings.present?
    end

    def self.mobile_push?
      false # TODO: implement mobile check
    end

    def self.instant_messenger?
      const_defined?('TownCrier::Config::Jabber')
    end

    # override to provide special formatting for certain media types
    def self.format text
      return text
    end
  end

  class Email < Medium
    def self.transmit contact, text
      SampleMailer.sample_mail({contact: contact, text: format(text)}).deliver
    end
  end

  class Sms < Medium
    def self.transmit contact, text
      sms_client = SMSFu::Client.new
      sms_client.deliver(contact.cell_number, contact.cell_carrier, format(text))
    end
  end

  class MobilePush < Medium
    def self.transmit contact, text
      formatted = format(text)
      raise "haven't gotten to mobile push yet"
    end
  end

  class InstantMessage < Medium
    def self.transmit contact, text
      if instant_messenger?
        unless @client
          @client = Jabber::Simple.new(TownCrier::Config::Jabber['user'], TownCrier::Config::Jabber['pass'])
        end
        @client.deliver(contact.im, text)
      end
    end
  end
end
