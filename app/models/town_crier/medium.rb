module TownCrier
  class Medium
    def self.get(name)
      self.const_get(name.camelize, false)
    end

    class Email
      def transmit contact, text
      end
    end
    class Sms
      def transmit contact, text
        SMSFu.deliver(contact.cell_number, contact.cell_carrier, text)
      end
    end
    class MobilePush
      def transmit contact, text
        raise "haven't gotten to mobile push yet"
      end
    end
    class InstantMessage
      def transmit contact, text
        raise "haven't gotten to instant message yet"
      end
    end
  end
end
