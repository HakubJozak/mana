module XpathHelper
  include ::XPath
  extend self
  
  def section_button(user, section, button)
    xpath = descendant[attr(:class).includes('side-panel')]
    xpath = xpath[attr(:id).includes(user)]
    xpath = xpath[descendant.text.is section]
    xpath = xpath[descendant.text.is button]
    xpath
  end
end

World(XpathHelper)