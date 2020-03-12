module Slugifiable
    module ClassMethods
        def find_by_slug(slug)
            self.all.find {|i| i.slug == slug}
        end
    end
    module InstanceMethods
        def slug
            split = self.name.split(/\s|[(.)!,?\\-]/).reject {|n| n == ""}
            split.join("-").downcase
        end
    end
end