extends Node2D
class_name Boss


export(Array,String,FILE) var attack_paths
var attacks : Array

var attack_index: int
onready var horse := $Horse

func _ready():
	call_deferred("main_loop")
	load_attacks()

func load_attacks():
	for attack_path in attack_paths:
		var attack = load(attack_path).new()
		attacks.append(attack)

func choose_attack():
	if attacks.size() == 1:
		return attacks[0]
	
	return attacks[(attack_index+randi()%(attacks.size()-1))%attacks.size()]


func main_loop():
	while true:
		var attack = choose_attack()
		if attack.pre_delay > 0: yield(Tools.timer(attack.pre_delay),"timeout")
		attack.attack(horse)
		yield(Tools,"attack_finished")
		if attack.post_delay > 0: yield(Tools.timer(attack.post_delay),"timeout")
	
