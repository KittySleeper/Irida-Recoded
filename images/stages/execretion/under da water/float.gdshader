shader_type canvas_item;

void vertex() {
	
	VERTEX.y += 10.0 * sin(TIME) * TAU;
}


