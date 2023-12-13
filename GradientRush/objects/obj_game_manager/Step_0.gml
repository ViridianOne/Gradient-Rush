if(keyboard_check_pressed(vk_escape)) {
	is_paused = !is_paused;
	layer_set_visible("Pause", is_paused);
	if(is_paused) {
		camera_x = camera_get_view_x(view_camera[0]);
		camera_y = camera_get_view_y(view_camera[0]);
	}
	camera_set_view_size(view_camera[0], is_paused ? 1920 : 768,  is_paused ? 1080 : 432);
	camera_set_view_pos(view_camera[0], is_paused ? 0 : camera_x, is_paused ? 0 : camera_y);
	global_speed = is_paused ? 0 : 1;
}

switch(location) {
	case 120:
		obj_add.location = COLORS.GREEN;
		break;
	case 300:
		obj_add.location = COLORS.MAGENTA;
		break;
}
