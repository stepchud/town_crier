module TownCrier
  module ActiveRecordExtensions
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
    end
  end
end

module ClassMethods
  ##
  # This model makes proclamations about lifecycle events
  #
  def acts_as_town_crier(*args)
    after_create(:model_create) if args.include?(:create)
    after_update(:model_update) if args.include?(:update)
    after_destroy(:model_destroy) if args.include?(:destroy)
  end

  ##
  # This is a "User" type object that can be sent messages
  # TownCrier::Contact has a reference to a contactable instance
  def town_ctrier_contactable
    TownCrier.contactable_type=self.class
  end
end

module InstanceMethods
  def model_create
    TownCrier::Proclamation.announce("#{self.class.to_s}:#{self.id}:created")
  end
  def model_create
    TownCrier::Proclamation.announce("#{self.class.to_s}:#{self.id}:updated")
  end
  def model_destroy
    TownCrier::Proclamation.announce("#{self.class.to_s}:#{self.id}:destroyed")
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send(:include, TownCrier::ActiveRecordExtensions)
end
