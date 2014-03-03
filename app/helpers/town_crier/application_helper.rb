module TownCrier
  module ApplicationHelper
    def start_over
      '<p><a href="/">Start Over</a></p>'.html_safe
    end
    def contacts_select(f)
      select_tag 'proclamation[options][to]', options_from_collection_for_select(TownCrier::Contact.all, 'id', 'name')
    end
  end
end
