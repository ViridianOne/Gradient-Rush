if(keyboard_check_pressed(vk_escape)) {
	is_paused = !is_paused;
	layer_set_visible("Pause", is_paused);
	camera_set_view_size(view_camera[0], is_paused ? 1920 : 768,  is_paused ? 1080 : 432);
	global_speed = is_paused ? 0 : 1;
}
