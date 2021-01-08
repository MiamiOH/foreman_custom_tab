if SETTINGS[:custom_tab]
  Deface::Override.new(:virtual_path => 'hosts/show',
                       :name => 'custom_tab_add_tab',
                       :insert_bottom => 'ul#host-show-tabs',
                       :text =>
                       "<li><a href='#custom_tab' data-toggle='tab'><%= _(custom_tab_title) %></a></li>")
end
