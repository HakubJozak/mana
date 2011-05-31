require 'bermuda/cucumber'

module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
      when /the #{REQUIRED} accordion section/
       [:xpath, Bermuda::XPath.accordion_content($1)]
     when /the #{REQUIRED} dialog/
       [:xpath, Bermuda::XPath.dialog($1)]
     when /the #{REQUIRED} tab/
       [:xpath, Bermuda::XPath.tab_content($1)]
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end


World(HtmlSelectorsHelper)