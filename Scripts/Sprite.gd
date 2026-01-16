extends Sprite

export(NodePath) onready var animacao=get_node(animacao);

func toca_animacao(movimento:Vector2)->void:
	vira(movimento);
	movimentacao(movimento);



func vira(movimento:Vector2) ->void:
	if movimento.x>0:
		flip_h=false;
	
	elif movimento.x<0:
		flip_h=true;
	
	else:pass
	
	
func movimentacao(movimento:Vector2)->void:
	if movimento.y==0:
		if movimento.x==0:
			animacao.play("parado");
		else:
			animacao.play("anda");
	
	else:pass;
		
		

func animacao_pulo(movimento:Vector2)->void:
	animacao.play("pulo");
	
	
	
func animacao_cai()->void:
	animacao.play("queda");
