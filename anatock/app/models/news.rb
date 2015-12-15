class News < ActiveRecord::Base
  attr_accessible :num , :date , :title , :contents , :url
end
