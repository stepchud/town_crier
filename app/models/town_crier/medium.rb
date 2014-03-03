require 'xmpp4r-simple'

module TownCrier
  class Medium
    def self.get(name)
      self.const_get(name.camelize, false)
    end

    def self.available
      available = []
      available << :sms << :email if email?
      available << :mobile if mobile?
      available << :im if im?
      available
    end

    # checks if an email address is configured
    def self.email?
      ActionMailer::Base.smtp_settings.present?
    end

    def self.mobile_push?
      false # TODO: implement mobile check
    end

    def self.im?
      const_defined?('TownCrier::Config::Jabber')
    end

    class Email
      def self.transmit contact, text
        SampleMailer.sample_mail({contact: contact, text: text}).deliver
      end
    end

    class Sms
      def self.transmit contact, text
        sms_client = SMSFu::Client.new
        SMSFu.deliver(contact.cell_number, contact.cell_carrier, text)
      end
    end

    class MobilePush
      def self.transmit contact, text
        raise "haven't gotten to mobile push yet"
      end
    end

    class InstantMessage
      def self.transmit contact, text
        if Medium.im?
          unless @client
            @client = Jabber::Simple.new(TownCrier::Config::Jabber['user'], TownCrier::Config::Jabber['pass'])
          end
          @client.deliver(contact.im, text)
        end
      end
    end
  end
end
