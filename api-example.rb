Smooth.new do

  title      "API"

  author     "J Holderbaum"
  company    "Foo"
  email      "mail@foo.bar"
  date       DateTime.now
  venue      "Interwebz"

  slides do
    slide "Title of Slide #1" do
      box "Some text in this section" do
        text "Look at this, I'm in a paragraph"
      end
      
      box "Look at this list" do
        list do
          * "Something"
          * "In a list"
          * "I hope, the star can be used as method name"
          * "But since we are driving ruby, I don't see any problems"
          * "With this ^^"
        end
      end
    end

    slide "Vertical centering" do
      box "This content is vertical centered", :vcenter => true do
        text "This is the box content"
      end
    end

    slide "Syntax highlighting" do
      box "Syntax highlighting is very simple:" do
        code :ruby, <<-EOC
          class Syntax
            def case_sensitive
              true
            end
          end
        EOC
      end
    end

    slide "Boxes" do
      box do
        text "A box can be used without a title, too."
      end
    end
  end
end
