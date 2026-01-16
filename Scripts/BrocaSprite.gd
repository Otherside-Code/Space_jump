extends Sprite

func vira(movimento)->void:
	if movimento.x<0:
		flip_h=true;
	else:
		flip_h=false;
