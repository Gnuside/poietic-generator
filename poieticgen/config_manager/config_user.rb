##############################################################################
#                                                                            #
#  Poietic Generator Reloaded is a multiplayer and collaborative art         #
#  experience.                                                               #
#                                                                            #
#  Copyright (C) 2011-2013 - Gnuside                                         #
#                                                                            #
#  This program is free software: you can redistribute it and/or modify it   #
#  under the terms of the GNU Affero General Public License as published by  #
#  the Free Software Foundation, either version 3 of the License, or (at     #
#  your option) any later version.                                           #
#                                                                            #
#  This program is distributed in the hope that it will be useful, but       #
#  WITHOUT ANY WARRANTY; without even the implied warranty of                #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero  #
#  General Public License for more details.                                  #
#                                                                            #
#  You should have received a copy of the GNU Affero General Public License  #
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.     #
#                                                                            #
##############################################################################

module PoieticGen ; class ConfigManager

	class ConfigUser
		attr_reader :max_clients
		attr_reader :max_idle
		attr_reader :alive_timeout
		attr_reader :keepalive

		def initialize hash
			raise MissingField,"User.max_clients" unless hash.include? "max_clients"
			@max_clients = ConfigManager.parse_int hash["max_clients"], "User.max_clients"

			raise MissingField, "User.alive_timeout" unless hash.include? "alive_timeout"
			@alive_timeout = ConfigManager.parse_int hash["alive_timeout"], "User.alive_timeout"

			raise MissingField, "User.max_idle" unless hash.include? "max_idle"
			@max_idle = ConfigManager.parse_int hash["max_idle"], "User.max_idle"

			raise MissingField, "User.keepalive" unless hash.include? "keepalive"
			@keepalive = ConfigManager.parse_int hash["keepalive"], "User.keepalive"
		end
	end

end ; end
