class BlogPost < ActiveRecord::Base
	acts_as_taggable
	acts_as_votable
	acts_as_paranoid
	has_paper_trail
	extend FriendlyId
	
	belongs_to :user
	has_many :comments

	friendly_id :title, use: [:slugged, :history]

	# Use default slug, but upper case and with underscores
  def normalize_friendly_id(string)
    super.gsub("-", "_")
  end
end
