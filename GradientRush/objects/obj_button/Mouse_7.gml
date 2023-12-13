switch(interface_type) {
	case INTERFACE_TYPES.MAIN:
		room_goto(rm_main_menu);
		break;
	case INTERFACE_TYPES.GAME:
		room_goto(rm_relativie);
		break;
	case INTERFACE_TYPES.CONTINUE:
		if(instance_exists(obj_game_manager)) {
			obj_game_manager.is_paused = false;
			camera_set_view_size(view_camera[0], 768, 432);
			layer_set_visible("Pause", false);
		}
		break;
	case INTERFACE_TYPES.QUIT:
		game_end();
		break;
}
