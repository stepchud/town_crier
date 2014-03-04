module TownCrier
  class Contact < ActiveRecord::Base
    cattr_accessor :contactable # class which models Users in the mounted Rails app

    validates_presence_of :name
    validates_uniqueness_of :name

    # TODO: implement event subscriptions
    def self.interested_in(proclamation)
      where("1=0")
    end

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
