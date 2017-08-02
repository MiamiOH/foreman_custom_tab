if SETTINGS[:custom_tab]
  Deface::Override.new(
                     :virtual_path => "hosts/show",
                     :name => "add_tab_link",
                     :insert_bottom => "ul#myTab",
                     :text => "  <li><a href=\"#summary\" data-toggle=\"tab\"><%= _('Summary') %></a></li>"
                     )
end