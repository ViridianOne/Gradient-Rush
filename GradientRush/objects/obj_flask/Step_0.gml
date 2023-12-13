if(is_thrown) {
	h_spd = spd * sin(point_direction(x, y, obj_relativie.x, obj_relativie.y));
	v_spd = spd * cos(point_direction(x, y, obj_relativie.x, obj_relativie.y));
	x += 2 * sin(point_direction(x, y, obj_relativie.x, obj_relativie.y));
	y += 2 * cos(point_direction(x, y, obj_relativie.x, obj_relativie.y));
} else if(is_grabbed) {
	x += obj_add.x - obj_add.xprevious;
	y += obj_add.y - obj_add.yprevious;
}
