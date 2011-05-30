module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
      when /the "([^"]+)" accordion section/
       [:xpath, Bermuda::XPath.accordion_content($1)]
     when /the "([^"]+)" dialog/
       [:xpath, Bermuda::XPath.dialog($1)]
     when /the "([^"]+)" tab/
       [:xpath, Bermuda::XPath.tab_content($1)]
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end


World(HtmlSelectorsHelper)