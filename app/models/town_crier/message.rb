module TownCrier
  class Message < ActiveRecord::Base
    # STATUSES
    New = :new
    Pending = :pending
    Delivered = :delivered
    Failed = :failed

    belongs_to :contact
    belongs_to :proclamation

    before_create :set_new_status

    def deliver(options)
      text = options[:text] || generate(proclamation)
      medium = Medium.get(via)
      begin
        update_attributes!(formatted_text: format(text), status: Pending)
        medium.transmit(contact, formatted_text)
        update_status(Delivered)
      rescue
        update_status(Failed)
      end
    end

    def update_status(status)
      update_attributes(status: status)
    end

    private
    def set_new_status
      if status.nil?
        self.status = New
      end
    end
  end
end
