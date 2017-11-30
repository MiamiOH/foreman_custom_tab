if SETTINGS[:custom_tab]
  Deface::Override.new(
                     :virtual_path => "hosts/show",
                     :name => "add_tab_link",
                     :insert_bottom => "ul#myTab",
                     :text => "  <li><a href=\"#custom_tab\" data-toggle=\"tab\"><%= _('Custom Tab') %></a></li>"
                     )
end