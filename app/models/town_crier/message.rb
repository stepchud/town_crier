module TownCrier
  class Message < ActiveRecord::Base
    belongs_to :contact

    def deliver(options)
      text = options[:text] || generate(proclamation)
      medium = Medium.get(via)
      self.formatted = format text
      self.save!
      medium.trasmit(contact, formatted)
    end
  end
end
