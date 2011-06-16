

/**
 * Global view
 */
function Board( p_session ) {
	var console = window.noconsole;

	var self = this;

    this.name = "Board";

	var _real_canvas = null;
	var _context = null;
	var _zones = null;
	var _users = null;
	var _session = null;


	/**
	 * Constructor
	 */
	this.initialize = function( p_session ) {

		_session = p_session;
		_session.register( self );
		_zones = {};
		_users = {};

		// fill zones with zones from session
		_zones[_session.user_zone.index] = new Zone(
				_session,
				_session.user_zone.index,
				_session.user_zone.position,
				_session.zone_column_count,
				_session.zone_line_count
				);

		for (var i=0; i<p_session.other_zones.length; i++) {
			var z = p_session.other_zones[i];

			_zones[z.index] = new Zone(
					_session,
					z.index, z.position,
					_session.zone_column_count, _session.zone_line_count
					);
		}
		console.log("board/initialize: zones = %s", JSON.stringify( _zones ) );
	}


	/**
	 *
	 */
	this.handle_event = function( ev ) {
		console.log("board/handle_event : %s", JSON.stringify( ev ) );
		if ( ev.type == 'join' ) {
			var z = ev.desc.zone;
			_zones[z.index] = new Zone(
					_session,
					z.index, z.position,
					_session.zone_column_count, _session.zone_line_count
					);
		} else if ( ev.type == 'leave' ) {
			var z = ev.desc.zone;
			_zones.splice(z.index,1);
		} else {
			// FIXME: unknown event...
		}
	}


	/**
	 *
	 */
	this.get_zone = function( index ) {
		// console.log("board/get_zone(%s) : %s", index, JSON.stringify( _zones[index] ) );
		return _zones[index];
	}


	/**
	 * Return the list of existing zone ids
	 */
	this.get_zone_list = function() {
		var keys = [];
		for(var i in _zones) {
			if (_zones.hasOwnProperty(i))
			{
				keys.push( parseInt(i,10) );
			}
		}
		// console.log("board/get_zone_list : %s", JSON.stringify( keys ));
		return keys;
	}


	/**
	 *
	 */
	this.handle_stroke = function( stk ) {
		console.log("board/handle_stroke : stroke = %s", JSON.stringify( stk ));
		console.log("board/handle_stroke : zones = %s", JSON.stringify( _zones ));
		var z = _zones[stk.zone];

		z.patch_apply( stk );
	}


	this.initialize( p_session );
}

