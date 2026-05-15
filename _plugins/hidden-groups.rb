module Jekyll
  class HidePostGroupsGenerator < Generator
    safe true
    priority :high

    def generate(site)
      hidden = site.config['hidden_post_groups'] || []
      return if hidden.empty?

      site.posts.docs.reject! do |post|
        cats = post.data['categories'] || []
        hidden.any? { |h| cats.include?(h) }
      end
    end
  end
end
