if((room == rm_main_menu || instance_exists(obj_game_manager) && obj_game_manager.is_paused) && point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), bbox_left, bbox_top, bbox_right, bbox_bottom)) {
	if(mouse_check_button_pressed(mb_left)) {
		audio_play_sound(snd_click, 1, false);
	}
	if(mouse_check_button_released(mb_left)) {
		switch(interface_type) {
			case INTERFACE_TYPES.MAIN:
				room_goto(rm_main_menu);
				break;
			case INTERFACE_TYPES.GAME:
				room_goto(rm_green);
				break;
			case INTERFACE_TYPES.CONTINUE:
				if(instance_exists(obj_game_manager)) {
					obj_game_manager.is_paused = false;
					camera_set_view_size(view_camera[0], 768, 432);
					layer_set_visible("Pause", false);
				}
				break;
			case INTERFACE_TYPES.FEEDBACK:
				url_open("https://forms.gle/gbExcBEH7BKHk6qr5");
				break;
			case INTERFACE_TYPES.SOUND_SWITCHER:
				obj_music_manager.is_sound_on = !obj_music_manager.is_sound_on;
				audio_group_set_gain(audiogroup_default, obj_music_manager.is_sound_on ? 1 : 0, 0);
				label = $"Sounds: {obj_music_manager.is_sound_on ? "ON" : "OFF"}";
				break;
			case INTERFACE_TYPES.QUIT:
				game_end();
				break;
		}
	} else {
		image_index = 0;
		color = c_white;
	}
} else {
	image_index = 1;
	color = c_black;
}
