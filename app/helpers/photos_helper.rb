module PhotosHelper

  def get_clean_url description
    description.split("<img src=").last.split(".jpg").first.gsub("\"", "")
  end

  def get_author name
    name.gsub("nobody@flickr.com (", "") 
  end
end
