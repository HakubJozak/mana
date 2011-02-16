module BoxHelper
      def box(type)
        name = type.split('-').first.capitalize

        haml_tag ".box-container" do
          haml_tag :h4 do
            haml_concat name
            haml_tag "a.browse-button.button", 'Browse'
          end

          haml_tag :div,  { :class => "box #{type}", :id => "#{type}-$USER_ID" } do
            if block_given?
              yield
            else
              haml_tag '.button-bar' do
                haml_tag 'h4', name
                haml_tag 'a.shuffle-button.button', 'Shuffle'
                haml_tag 'a.uncover-button.button', 'Uncover All'
                haml_tag 'a.cover-button.button', 'Cover All'                
                haml_tag 'a.close-button.button', 'Close'
              end
            end
          end        
        end
      end
end
