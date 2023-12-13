if(place_meeting(x-1, y-1, obj_add) || place_meeting(x+1, y+1, obj_add)) {
	if(obj_add.green_interaction.more_complementary && can_destroy) {
		strength -= obj_add.green_interaction.destroying_time;
		can_destroy = false;
		if(strength > 0) {
			alarm[0] = 60;
		}
	}
}

if(strength <= 0 && !can_destroy) {
	obj_add.green_interaction.more_complementary = false;
	if(tile_layer_name != "" || tile_layer_name != noone) {
		layer_set_visible(tile_layer_name, false);
	}
	instance_destroy(color_ground);
	instance_destroy();
} 
