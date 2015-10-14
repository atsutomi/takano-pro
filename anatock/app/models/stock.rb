class Stock < ActiveRecord::Base
  attr_accessible :num, :market, :name, :hp, :tw, :fb, :business
  class << self
    def search(query)
      rel = order("num")
      if query.present?
        rel = rel.where("market LIKE? OR business LIKE ?",
                "%#{query}%", "%#{query}%")
      end
      rel
    end
  end
end
