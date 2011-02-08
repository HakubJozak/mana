module BoxHelper
      def box(id, has_id = true)
        name = id.split('-').first.capitalize

        haml_tag ".box-container" do
          haml_tag :h4 do
            haml_concat name
            haml_tag "a.browse-button.button", 'Browse' if has_id
          end

          params = if has_id
                     { :id => id, :class => "box" }
                   else
                     { :class => "box #{id}" }
                   end
          
          haml_tag :div, params do
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
