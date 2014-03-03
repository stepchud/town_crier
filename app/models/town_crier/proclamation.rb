module TownCrier
  class Proclamation < ActiveRecord::Base
    serialize :options, ::JSON

    has_many :messages

    after_create :announce_later

    ##
    # Proclamation format for lifecycle events:
    # "ModelName:id:(create|update|destroy)"
    #
    # Proclamation format for time based events:
    # "EventModel:current_timestamp:due_timestamp"
    #
    # options:
    # to: array or scope of Contacts
    # via: array of media to distribute the message through
    def self.announce(proclamation)
      crowd = options[:to] || TownCrier::Contact.interested_in(proclamation)
      crowd = TownCrier::Contact.all if crowd==:all
      media = options[:via] || TownCrier::Medium.available.include?(proclamation)
      crowd.each do |contact|
        media.each do |medium|
          if contact.reachable_by?(medium)
            message = TownCrier::Message.create!(proclamation: proclamation, contact: contact, via: medium)
            message.deliver(options)
          end
        end
      end
    end

    private
    # Create a thread to deliver the messages later
    def announce_later
      logger.info("Proclamation#announce_later")
      Thread.new do
        Proclamation.announce(self)
      end
    end
  end
end
