module TownCrier
  class Proclamation < ActiveRecord::Base
    serialize :options, ::JSON

    belongs_to :from, :class_name => 'TownCrier::Contact'
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
    def announce
      crowd.each do |contact|
        media.each do |medium|
          if contact.reachable_by?(medium)
            message = TownCrier::Message.create!(proclamation: self, contact: contact, medium: medium)
            message.deliver
          end
        end
      end
    end

    ##
    # everyone who should receive this message
    # either specified in options[:to] or from interest
    def crowd
      case options['to']
      when :all
        TownCrier::Contact.all
      when nil
        TownCrier::Contact.interested_in(self)
      else # array of contact ids
        TownCrier::Contact.where(id: options['to'])
      end
    end

    def media
      options['via'] || TownCrier::Medium.available
    end

    private
    # Create a thread to deliver the messages later
    def announce_later
      # Thread.new do
        # begin
          self.announce
        # ensure
        #   ActiveRecord::Base.connection.close
        # end
      # end
    end
  end
end
