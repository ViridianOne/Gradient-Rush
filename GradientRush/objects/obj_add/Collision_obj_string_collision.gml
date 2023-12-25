if(string_interaction.number != other.string_number) {
	var _is_horizontal = false;
	var _len = 0;
	for(var _i = 1; _i < array_length(other.x_points); _i++) {
		_len += sqrt(sqr(other.x_points[_i - 1] - other.x_points[_i]) + sqr(other.y_points[_i - 1] - other.y_points[_i]) ^ 2);
		if(other.x_points[_i - 1] - other.x_points[_i] != 0 
			&& (x >= other.x_points[_i - 1] && x < other.x_points[_i]
			|| x >= other.x_points[_i] && x < other.x_points[_i - 1])) {
			_len -= abs(x - other.x_points[_i]);
			string_interaction.is_horizontal = true;
			break;
		}
		
		if(other.y_points[_i - 1] - other.y_points[_i] != 0 
			&& (y >= other.y_points[_i - 1] && y < other.y_points[_i]
			| y >= other.y_points[_i] && y < other.y_points[_i - 1])) {
			_len -= abs(y - other.y_points[_i]);
			string_interaction.is_horizontal = false;
			break;
		}
	}
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
	
	path_start(other.string_path, string_interaction.const_sliding_spd, path_action_stop, true);
	path_position = _len / path_get_length(other.string_path);
	state = ADD_STATES.ON_STRINGS;
}

string_interaction.relationship = get_color_relationship(other.color_hue, color);

/*state = ADD_STATES.ON_STRINGS;
string_interaction.relationship = get_color_relationship(other.color_hue, color);
//string_interaction.prev_pos += 1;

if(string_interaction.number != other.string_number) {
	string_interaction.number = other.string_number;
	var _collisions_number = instance_number(obj_string_collision);
	var _collision = noone;
	for(var _i = 0; _i < _collisions_number; _i++) {
		_collision = instance_find(obj_string_collision, _i);
		if(_collision != -1) {
			_collision.color_hue = color;
			_collision.image_blend = get_image_blend(_collision.color_hue);
		}
	}
} else if(x > string_interaction.next_x_point - 3 && x < string_interaction.next_x_point + 3
	|| y > string_interaction.next_y_point - 3 && y < string_interaction.next_y_point + 3
	|| string_interaction.next_x_point == -1 && string_interaction.next_y_point == -1) {
	for(var _i = 1; _i < array_length(other.x_points); _i++) {
		string_interaction.x_cond = other.x_points[_i - 1] - other.x_points[_i] < 0 
			&& x >= other.x_points[_i - 1] && x < other.x_points[_i];
		if(other.x_points[_i - 1] - other.x_points[_i] < 0 
			&& x >= other.x_points[_i - 1] && x < other.x_points[_i]) {
			h_spd = string_interaction.const_sliding_spd;
			string_interaction.next_x_point = other.x_points[_i];
			break;
		} else if (other.x_points[_i - 1] - other.x_points[_i] > 0 
			&& x >= other.x_points[_i] && x < other.x_points[_i - 1]) {
			h_spd = -string_interaction.const_sliding_spd;
			string_interaction.next_x_point = other.x_points[_i];
			break;
		} else {
			h_spd = 0;
			string_interaction.next_x_point = -1;
		}
		
		string_interaction.y_cond = other.y_points[_i - 1] - other.y_points[_i] < 0 
			&& y >= other.y_points[_i - 1] && y < other.y_points[_i];
		if(other.y_points[_i - 1] - other.y_points[_i] < 0 
			&& y >= other.y_points[_i - 1] && y < other.y_points[_i]) {
			v_spd = string_interaction.const_sliding_spd;
			string_interaction.next_y_point = other.y_points[_i];
			break;
		} else if (other.y_points[_i - 1] - other.y_points[_i] > 0 
			&& y >= other.y_points[_i] && y < other.y_points[_i - 1]) {
			v_spd = -string_interaction.const_sliding_spd;
			string_interaction.next_y_point = other.y_points[_i];
			break;
		} else {
			v_spd = 0;
			string_interaction.next_y_point = -1;
		}
		
	}
}

		x += h_spd * obj_game_manager.global_speed;
		y += v_spd * obj_game_manager.global_speed;
*/