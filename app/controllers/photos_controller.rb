class PhotosController < ApplicationController
  require 'open-uri'
  require 'json'

  def index
    @jsonresults =  open("http://api.flickr.com/services/feeds/photos_public.gne?format=json").read
    get_parsed_results
  end

  def show
    author_id = params[:id]
    @jsonresults =  open("http://api.flickr.com/services/feeds/photos_public.gne?format=json&&id=#{author_id}").read
    get_parsed_results
  end

  def friends_photos
   contact_id = params[:id]
   @jsonresults =  open("https://api.flickr.com/services/feeds/photos_friends.gne?user_id=#{contact_id}&&format=json&&friends=1&&&&nojsoncallback=1").read
   get_parsed_results
 end


 private

 def get_parsed_results
   @json_hash = JSON.load(@jsonresults.to_json).gsub("jsonFlickrFeed(", "").gsub(")", "")
   @results = JSON.parse(@json_hash)
 end

end
