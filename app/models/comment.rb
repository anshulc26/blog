class Comment < ActiveRecord::Base
	acts_as_paranoid
	has_paper_trail
	
  belongs_to :blog_post
  belongs_to :user
end
