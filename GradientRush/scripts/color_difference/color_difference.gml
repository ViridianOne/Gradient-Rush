function get_color_relationship(_first, _second) {
	var _difference = abs(_first - _second);
	if(_difference > 180) {
		_difference -= _difference % 180 * 2;
	}
	
	switch(_difference) {
		case 0:
			return RELATIONSHIPS.MONOCHROMATIC;
		case 30:
			return RELATIONSHIPS.ANALOGOUS;
		case 60:
			return RELATIONSHIPS.SPLIT_ANALOGOUS;
		case 90:
			return RELATIONSHIPS.TETRADIC;
		case 120:
			return RELATIONSHIPS.TRIADIC;
		case 150:
			return RELATIONSHIPS.SPLIT_COMPLEMENTARY;
		case 180:
			return RELATIONSHIPS.COMPLEMENTARY;
		default:
			return RELATIONSHIPS.NEUTRAL;
	}
}
