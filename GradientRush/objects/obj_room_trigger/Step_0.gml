function move_camera_horizontally() {
	if(obj_add.x >= x && obj_add.x < x + sprite_width / 3) {
		obj_camera_point.x = x + camera_get_view_width(cam) / 2;
	} else if(obj_add.x >= x + sprite_height / 3 && obj_add.x < x + 2 * sprite_height / 3) {
		obj_camera_point.x = x + sprite_width / 2;
	} else {
		obj_camera_point.x = x + sprite_width - camera_get_view_width(cam) / 2;
	}
}

function move_camera_vertically() {
	if(obj_add.y >= y && obj_add.y < y + sprite_height / 3) {
		obj_camera_point.y = y + camera_get_view_height(cam) / 2;
	} else if(obj_add.y >= y + sprite_height / 3 && obj_add.y < y + 2 * sprite_height / 3) {
		obj_camera_point.y = y + sprite_height / 2;
	} else {
		obj_camera_point.y = y + sprite_height - camera_get_view_height(cam) / 2;
	}
}

is_player_inside = place_meeting(x, y, obj_add)

if(is_player_inside) {
	/*if(obj_add.x > x + camera_get_view_width(cam) / 4 && obj_add.x <  x + sprite_width - camera_get_view_width(cam) / 4) {
		obj_camera_point.x = obj_add.x;
	} else {
		move_camera_horizontally();	
	}
	if(obj_add.y - obj_add.sprite_height / 2 > y + camera_get_view_height(cam) / 4 && obj_add.y - obj_add.sprite_height / 2 < y + sprite_height - camera_get_view_height(cam) / 4) {
		obj_camera_point.y = obj_add.y;
	} else {
		move_camera_vertically();
	}*/
	if(can_move_camera) {
		move_camera_horizontally();
		move_camera_vertically();
		can_move_camera = false;
		can_camera_move_with_player = true;
	} else if(can_camera_move_with_player) {
		if(obj_add.x > x + camera_get_view_width(cam) / 2 && obj_add.x <  x + sprite_width - camera_get_view_width(cam) / 2) {
			obj_camera_point.x = obj_add.x;
		}
		if(obj_add.y - obj_add.sprite_height / 2 > y + camera_get_view_height(cam) / 2 && obj_add.y - obj_add.sprite_height / 2 < y + sprite_height - camera_get_view_height(cam) / 2) {
			obj_camera_point.y = obj_add.y - obj_add.sprite_height;
		}
	}
}
