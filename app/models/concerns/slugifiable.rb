
module Slug

    module InstanceMethods

        def slug
            self.name.strip.downcase.gsub(/[\s]/, '-')
        end

    end

    module ClassMethods

        def find_by_slug(slug)
            find_by("name like ?", slug.gsub(/[-]/, ' '))
        end

    end

end