class PhotosController < ApplicationController
  require 'open-uri'
  require 'json'

  def index
    @jsonresults =  open("http://api.flickr.com/services/feeds/photos_public.gne?format=json").read
    @json_hash = JSON.load(@jsonresults.to_json).gsub("jsonFlickrFeed(", "").gsub(")", "")#.first
    @results = JSON.parse(@json_hash)
  end

  def show
    author_id = params[:id]
    @jsonresults =  open("http://api.flickr.com/services/feeds/photos_public.gne?format=json&&id=#{author_id}").read
    @json_hash = JSON.load(@jsonresults.to_json).gsub("jsonFlickrFeed(", "").gsub(")", "")
    @results = JSON.parse(@json_hash)
  end

  def friends_photos
   contact_id = params[:id]
   @jsonresults =  open("https://api.flickr.com/services/feeds/photos_friends.gne?user_id=#{contact_id}&&format=json&&friends=1&&&&nojsoncallback=1").read
   @json_hash = JSON.load(@jsonresults.to_json).gsub("jsonFlickrFeed(", "").gsub(")", "")
   @results = JSON.parse(@json_hash)
 end

 def friends_photos_public
  contact_id = params[:id]
  contact_results =  open("https://api.flickr.com/services/rest/?method=flickr.contacts.getPublicList&&api_key=533e7b41f75718c84c94dad1699f740d&&page=10&&per_page=10&&format=json&&nojsoncallback=1&&user_id=#{params[:id]}").read
  if JSON.parse(contact_results)['contacts']['contact']
    @contacts = JSON.parse(contact_results)['contacts']['contact'].map{ |i, arr| arr = i['nsid'] }
    @jsonresults =  open("http://api.flickr.com/services/feeds/photos_public.gne?format=json&&ids=#{@contacts.join(",")}").read
    @json_hash = JSON.load(@jsonresults.to_json).gsub("jsonFlickrFeed(", "").gsub(")", "")
    @results = JSON.parse(@json_hash)
  end
end
end
