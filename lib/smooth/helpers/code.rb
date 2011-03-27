module Smooth
  module Helpers
    module Code

      def code(language, theme, &block)
        code = capture_haml(&block)

        content(:head, capture_haml do
          haml_tag "link", :href => "#{css_path("uv/#{theme}")}", :rel => "stylesheet", :type => "text/css"
        end)
        Uv.parse(code , "xhtml", language.to_s, true, theme.to_s )
      end

    end
  end
end
