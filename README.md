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

The format for your yaml file should look like the following:

	---
	  :custom_tab:
	    :fields:
	      IP Address, ip
	      MAC Address, mac
	      OS: operatingsystem.to_label

##TODO

*add plugin settings file

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

