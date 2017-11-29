# ForemanCustomTab

Adds a new tab to the details page on Hosts. The fields on the tab are customizable.

## Installation

To install custom_tab require it in your gem file by adding the line

gem 'foreman_custom_tab'

then update foreman to include the gem with the command

bundle update foreman_custom_tab

## Configuration

If there is no configuration file then the tab should not appear on the detailed hosts screen, but if 
there is one and it is empty then it will appear without any fields. To setup the configuration file create
a new file named 'foreman_custom_tab.yaml' at the location /etc/foreman/plugins/

The keys are the display title and the values are the methods that are actually called to produce the value.

Example configuration:

```
:custom_tab:
  :fields:
    'Host Name': name
    'MAC Address': mac
    'IP Address': ip
    'Architecture': arch
    'Certificate Name': certname
    'OS Title': operatingsystem.title
    'OS Type': operatingsystem.type
  :title: foo
```

## Verify the Custom Tab is loaded
Navigate to /hosts/, click on one of the listed host. There should be tabs: 'Properties', 'Metrics', 'Templates', 'NICs' and 'Custom Tab or custom_tab.title'

## Development mode
Add the custom_tab config to <foreman_repo>/config/settings.yaml

Note: foreman running locally (i.e not installed via rpm/debian package) does not use settings from /etc/foreman/plugins/

## TODO

* add plugin settings file

## Notes

This project is still incomplete and in development. 

Copyright (c) 2017 Joe Lyons Stannard III

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

