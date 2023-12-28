if(is_thrown) {
	/*h_spd = spd * sin(point_direction(x, y, obj_relativie.x, obj_relativie.y));
	v_spd = spd * cos(point_direction(x, y, obj_relativie.x, obj_relativie.y));
	x += 3 * sin(point_direction(x, y, obj_relativie.x, obj_relativie.y));
	y += 3 * cos(point_direction(x, y, obj_relativie.x, obj_relativie.y));*/
	direction = point_direction(x, y, obj_relativie.x, obj_relativie.y);
	speed = 5;
} else if(is_grabbed) {
	x += obj_add.x - obj_add.xprevious;
	y += obj_add.y - obj_add.yprevious;
} else if(is_broken) {
	x = obj_relativie.x;
	y = obj_relativie.y;
}

audio_listener_position(obj_add.x, obj_add.y, 0);
