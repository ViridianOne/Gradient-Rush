enum COLORS {
	RED = 0,
	ORANGER = 30,
	YELLOW = 60,
	GREEN = 120,
	SPRING_GREEN = 150,
	CYAN = 180,
	AZURE = 210,
	BLUE = 240,
	VIOLET = 270,
	MAGENTA = 300,
	ROSE = 330,
	WHITE = 1,
	GRAY = 2,
	BLACK = 3
}

function get_image_blend(_color) {
	switch(_color) {
		case 0:
			return c_red;
		case 60:
			return c_yellow;
		case 120:
			return c_lime;
		case 180:
			return c_aqua;
		case 240:
			return c_blue;
		case 300:
			return c_fuchsia;
	}
}
