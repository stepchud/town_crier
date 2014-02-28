require "town_crier/engine"
require 'town_crier/active_record_extensions'

module TownCrier
  class Media
    def self.available
      available = []
      available << :sms << :email if email?
      available << :mobile if mobile?
      available << :im if im?
      available
    end

    # checks if an email address is configured
    def self.email?
      true # TODO: implement email check
    end

    def self.mobile_push?
      true # TODO: implement mobile check
    end

    def self.im?
      true # TODO: implement instant messenger check
    end
end
