class Link
  include Mongoid::Document
  include Mongoid::Slug

  # Embed data
  field :name, type: String
  field :description, type: String
  field :image_url, type: String

  # Reddit thread ID
  field :thread_id, type: String

  # Shortened link
  field :link, type: String
  slug :link

  def url
    "https://reddit.com/live/#{thread_id}"
  end
end
