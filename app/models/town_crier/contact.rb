module TownCrier
  class Contact < ActiveRecord::Base
    cattr_accessor :contactable # class which models Users in the mounted Rails app

    validates_presence_of :name
    def reachable_by?(medium)
      case medium.to_sym
      when :email
        self.email.present?
      when :sms
        self.cell_number.present?
      when :mobile_push
        self.mobile_push?
      when :im
        self.im.present?
      end
    end
  end
end
