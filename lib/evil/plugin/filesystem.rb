module Evil
  module Plugin
    
    class Filesystem
      
      def read_template_file(title)
        if template = Evil::Models::Template.find_by_title(title)
          template.source
        else
          raise Liquid::FileSystemError, "No such template '#{title}'"
        end
      end
      
    end
    
  end
  
end