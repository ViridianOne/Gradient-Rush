if(edge_angle == 0) {
	first_room.can_move_camera = other.y - other.sprite_height / 2 < y;
	second_room.can_move_camera = other.y - other.sprite_height / 2 >= y;
} else if(edge_angle == 90) {
	first_room.can_move_camera = other.x < x;
	second_room.can_move_camera = other.x >= x;
}

first_room.can_camera_move_with_player = false;
second_room.can_camera_move_with_player = false;
