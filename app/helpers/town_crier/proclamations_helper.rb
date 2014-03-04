module TownCrier
  module ProclamationsHelper
    def list_recipients
      @proclamation.crowd.collect(&:name).join(', ')
    end
    def list_media
      @proclamation.media.collect { |m| TownCrier::Medium.get_type(m) }.join(', ')
    end
  end
end
