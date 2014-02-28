module TownCrier
  class Proclamation < ActiveRecord::Base
    serialize :data, ::JSON

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
    def self.announce(proclamation, options={})
      crowd = options.delete(:to)  || TownCrier::Contact.interested_in(proclamation)
      crowd = TownCrier::Contact.all if crowd==:all
      media = options.delete(:via) || TownCrier::Medium.available_for(proclamation)
      crowd.each do |contact|
        media.each do |medium|
          if contact.reachable_by?(medium)
            message = TownCrier::Message.create!(proclamation: proclamation, contact: contact, via: medium)
            message.deliver(options)
          end
        end
      end
    end
  end
end
