class Photo < ActiveRecord::Base
  attr_accessible :author, :author_id, :link, :tags, :title
end
