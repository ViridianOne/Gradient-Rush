if(string_interaction.number != other.string_number) {
	var _is_horizontal = false;
	var _len = 0;
	for(var _i = 1; _i < array_length(other.x_points); _i++) {
		_len += sqrt(sqr(other.x_points[_i - 1] - other.x_points[_i]) + sqr(other.y_points[_i - 1] - other.y_points[_i]));
		if(other.x_points[_i - 1] - other.x_points[_i] != 0 
			&& (x >= other.x_points[_i - 1] && x <= other.x_points[_i]
			|| x >= other.x_points[_i] && x <= other.x_points[_i - 1])
			/*&& y >= other.y_points[_i - 1] - 32 && y <= other.y_points[_i - 1] + 32*/) {
			_len -= sqrt(sqr(x - other.x_points[_i]) + sqr(y - other.y_points[_i]));
			string_interaction.is_horizontal = true;
			break;
		}
		
		if(other.y_points[_i - 1] - other.y_points[_i] != 0 
			&& (y >= other.y_points[_i - 1] && y <= other.y_points[_i]
			|| y >= other.y_points[_i] && y <= other.y_points[_i - 1])
			&& x >= other.x_points[_i - 1] - 32 && x <= other.x_points[_i - 1] + 32) {
			_len -= sqrt(sqr(x - other.x_points[_i]) + sqr(y - other.y_points[_i]));
			string_interaction.is_horizontal = false;
			break;
		}
	}
	string_interaction.a = _len;
	string_interaction.b = path_get_length(other.string_number);
	string_interaction.number = other.string_number;
	//obj_game_manager.obj_speed_relativity = 0;
	var _collisions_number = instance_number(obj_string_collision);
	var _collision = noone;
	for(var _i = 0; _i < _collisions_number; _i++) {
		_collision = instance_find(obj_string_collision, _i);
		if(_collision != -1) {
			_collision.color_hue = color;
		}
	}
	
	fx_set_parameter(string_color_fx, "g_TintCol", get_tint_array(color));
	
	if(x >= other.x_points[array_length(other.x_points) - 1] - 128 && x <= other.x_points[array_length(other.x_points) - 1] + 128 
		&& y >= other.y_points[array_length(other.y_points) - 1] - 128 && y <= other.y_points[array_length(other.y_points) - 1] + 128) {
		string_interaction.spd_multiplier = -1;	
	} else {
		string_interaction.spd_multiplier = 1;
	}
	
	string_interaction.sliding_spd = string_interaction.const_sliding_spd * string_interaction.spd_multiplier;
	
	camera_set_view_pos(view_camera[0], x, y);
	//path_assign(path_index, other.string_path);
	path_start(other.string_path, string_interaction.sliding_spd, path_action_stop, true);
	camera_set_view_pos(view_camera[0], xprevious, yprevious);
	/*if(x >= other.x_points[array_length(other.x_points) - 1] - 128 && x <= other.x_points[array_length(other.x_points) - 1] + 128 
		&& y >= other.y_points[array_length(other.y_points) - 1] - 128 && y <= other.y_points[array_length(other.y_points) - 1] + 128) {
		path_position = 0.95;	
	} else if(x >= other.x_points[0] - 128 && x <= other.x_points[0] + 128 
		&& y >= other.y_points[0] - 128 && y <= other.y_points[0] + 128) {
		path_position = 0;
	} else*/ if(_len / path_get_length(other.string_path) > 1) {
		path_position = 1 - _len / path_get_length(other.string_path);
	} else {
		path_position = _len / path_get_length(other.string_path);
	}
	camera_set_view_pos(view_camera[0], x, y);
	state = ADD_STATES.ON_STRINGS;
	
	if(!audio_is_playing(snd_strings)) {
		string_sound = audio_play_sound(snd_strings, 2, true);
	}
	//camera_set_view_target(view_camera[0], obj_add);
}

string_interaction.relationship = get_color_relationship(other.color_hue, color);

if(string_interaction.prev_relationship == RELATIONSHIPS.NEUTRAL) {
	string_interaction.prev_relationship = string_interaction.relationship;
}
