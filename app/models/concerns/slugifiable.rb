module Slug
    module InstanceMethods
        def slug
            self.name.downcase.gsub(/[\s]/, '-')
        end
    end

    module ClassMethods
        def find_by_slug(slug)
            unslug = slug.gsub(/[-]/, " ")
            find_by("name like ?", "#{unslug}")
        end
    end
end