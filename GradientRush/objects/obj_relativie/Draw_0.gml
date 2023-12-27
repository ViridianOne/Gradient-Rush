draw_self();

if(can_attract_player) {
	part_system_position(prt , x, y);
} else {
	part_system_position(prt, -100, -100);
}
