module Admin::TagsHelper
	def select_categories
		st = "<option></option>"
    @blog_tags = BlogTag.select(:category).group(:category)
    @blog_tags.each do |blog_tag|
  		st += '<option value="'+blog_tag.category+'">'+blog_tag.category.humanize.titleize+'</option>'
    end
    st.html_safe
	end
end
