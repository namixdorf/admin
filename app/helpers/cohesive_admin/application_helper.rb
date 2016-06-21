module CohesiveAdmin
  module ApplicationHelper

    def inverse_relationship_exists?(child, association, parent)
      association = association.to_s
      (parent.reflections.values.include?(child.reflections[association].inverse_of) rescue false)
    end

    def kaminari_url_for(page)
      
    end

  end
end
