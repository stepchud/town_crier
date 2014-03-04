module TownCrier
  class Message < ActiveRecord::Base
    # STATUSES
    Created = :new
    Pending = :pending
    Delivered = :delivered
    Failed = :failed

    belongs_to :contact
    belongs_to :proclamation

    before_create :initialize_status

    def deliver
      medium = Medium.get_type(self.medium)
      text = proclamation.full_text ||
             generate_message_for(proclamation, medium)
      begin
        set_status(Pending)
        medium.transmit(contact, text)
        set_status(Delivered)
      rescue
        update_attributes(status: Failed, status_message: $!.to_s)
      end
    end

    private
    def initialize_status
      self.status = Created if status.nil?
    end

    def set_status(status)
      update_attribute(:status, status)
    end

    ##
    # TODO: implement custom formatters for object lifecycle events / media
    def generate_message_for(proclamation, medium)
      "Hear Ye! An event transpired at #{proclamation.created_at}:\n\n#{proclamation.title}"
    end
  end
end
