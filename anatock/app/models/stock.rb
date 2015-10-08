class Stock < ActiveRecord::Base
  attr_accessible :num, :market, :name
  class << self
    def search(query)
      rel = order("num")
      if query.present?
        rel = rel.where("market LIKE?",
                "%#{query}%")
      end
      rel
    end
  end
end
