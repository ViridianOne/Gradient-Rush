switch(interface_type) {
	case INTERFACE_TYPES.MAIN:
		draw_sprite(spr_main_logo, 0, 100, 100);
		break;
	case INTERFACE_TYPES.PAUSE:
		draw_set_font(fnt_title);
		draw_set_color(c_black);
		draw_text(100, 150, "Pause");
		draw_set_font(fnt_button);
		break;
}
