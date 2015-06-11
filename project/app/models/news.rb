class News < ActiveRecord::Base
  attr_accessible :stock, :title, :content, :url
end
