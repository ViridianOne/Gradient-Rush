if(string_interaction.number != other.string_number) {
	for(var _i = 0; _i < array_length(other.x_points); _i++) {
		path_change_point(pth_string_test, _i, other.x_points[_i], other.y_points[_i], 100);
	}
	string_interaction.number = other.string_number;
	obj_game_manager.obj_speed_relativity = 0;
	var _collisions_number = instance_number(obj_string_collision);
	var _collision = noone;
	for(var _i = 0; _i < _collisions_number; _i++) {
		_collision = instance_find(obj_string_collision, _i);
		if(_collision != -1) {
			_collision.color_hue = color;
			_collision.image_blend = get_image_blend(_collision.color_hue);
		}
	}
	path_start(pth_string_test, string_interaction.const_sliding_spd, path_action_stop, true);
	state = ADD_STATES.ON_STRINGS;
}

string_interaction.relationship = get_color_relationship(other.color_hue, color);
