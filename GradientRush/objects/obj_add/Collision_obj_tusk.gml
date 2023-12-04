is_damaged = other.is_with_spikes;

if(!is_damaged && !other.is_damaged) {
	var _relationship_with_enemy = get_color_relationship(color, other.color);

	if(_relationship_with_enemy == RELATIONSHIPS.COMPLEMENTARY) {
		is_damaged = true;
		other.is_damaged = true;
	} else if(_relationship_with_enemy != RELATIONSHIPS.MONOCHROMATIC) {
		other.is_damaged = bbox_bottom <= other.bbox_top + 10 || state = ADD_STATES.DASHING;
		is_damaged = !other.is_damaged;
		can_jump_after_attack = !is_damaged;
	}
}
