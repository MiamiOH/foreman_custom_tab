if SETTINGS[:custom_tab]
  Deface::Override.new(
                    :virtual_path => 'hosts/show',
                    :name => 'create_link',
                    :insert_bottom => 'div#myTabContent',
                    :text => "\n  <div id='summary' class='tab-pane' data-ajax-url='<%= summary_host_path(@host)%>' data-on-complete='onContentLoad'>
                                    <%= spinner(_('Loading Summary information ...')) %>
                                   </div>"
                    )
end
