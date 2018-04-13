if SETTINGS[:custom_tab]
  Deface::Override.new(:virtual_path => 'hosts/show',
                       :name => 'custom_tab_add_tab_link',
                       :insert_bottom => 'div#myTabContent',
                       :text =>
                       "\n  <div id='custom_tab' class='tab-pane'
                       data-ajax-url='<%= custom_tab_host_path(@host)%>' data-on-complete='onContentLoad'>
                       <%= spinner(_('Loading Custom Tab information ...')) %>
                       </div>")
end
