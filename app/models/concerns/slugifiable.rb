module Slugifiable
    module Instance

        def slug
            self.name.downcase.gsub(/[ ']/, " " => "-", "'" => "")
        end

    end

    module Class
    
        def find_by_slug(slug)
            self.find { |member| member.slug == slug }
        end

    end

end