hp = 5;
is_active = true;

state = BOSSES_STATES.DID_NOT_DETECT;
sprite_index = spr_relativie_idle;
image_index = 0;
image_xscale = -1;

spd = 1;

//start
is_starting = false;
start_pos_y = 224;

//paths
current_path = pth_relativie_1;
next_path = pth_relativie_1;
start_path = function(_path, _spd) {
	path_start(_path, _spd, path_action_stop, true);
}

a = 1;

damage_boss = function() {
	if(state != BOSSES_STATES.DAMAGED) {
		state = BOSSES_STATES.DAMAGED;
		hp--;
		image_index = 0;
	}
}

//attraction
h_border = 168;
v_border = 168;
can_attract_player = false;
prt = part_system_create(prt_relativie);
