extends Node2D
class_name Boss

signal attack_finished

const bosshud_scene = preload("res://bosses/BossHUD.tscn")


export(float) var max_health = 15.0
export(Array,String,FILE) var attack_paths
export(NodePath) var path_to_boss_node
export(PackedScene) var next_phase
export(String,FILE) var entrance_animation
export(String,FILE) var death_animation
export(String,FILE) var next_phase_animation
export(String) var next_phase_sound
export(float) var next_phase_sound_start
export(float) var next_phase_sound_skip_at_end
export(String) var music
export(float) var music_start_time
export(float) var music_loop_start
export(float) var music_loop_end

onready var health : float = max_health
onready var boss_node : Node2D = get_node(path_to_boss_node)

var attacks: Array
var attack_index: int = -1

var dying : bool = false
var phase : int = 1

var boss_name: String
var boss_id: String
var animplayer := AnimationPlayer.new()

var attack

func _ready():
	if State.state["boss_phase"][boss_id] > phase:
		spawn_next_phase()
		return
	load_attacks()
	add_hud()
	add_animations()
	Audio.play_music(music,music_start_time,true,music_loop_start,music_loop_end)
	if entrance_animation != "": 
		animplayer.play("entrance")
		yield(animplayer,"animation_finished")
	call_deferred("main_loop")

func _process(delta):
	if attack is Attack:
		attack.process(delta,self)
	remove_health(delta)

func remove_health(delta):
	if not dying:
		health -= delta

func add_animations():
	add_child(animplayer)
	if entrance_animation != "": animplayer.add_animation("entrance",load(entrance_animation))
	if death_animation != "": animplayer.add_animation("death",load(death_animation))
	if next_phase != null: animplayer.add_animation("next_phase",load(next_phase_animation))
	

func add_hud():
	var bosshud = bosshud_scene.instance()
	bosshud.boss = self
	add_child(bosshud)
	
func main_loop():
	while true:
		if health <= 0.0:
			death()
			return
		attack = choose_attack()
		if attack.vars["pre_delay"] > 0: yield(Tools.timer(attack.vars["pre_delay"],self),"timeout")
		attack.attack(self)
		yield(self,"attack_finished")
		print("finished")
		if attack.vars["post_delay"] > 0: yield(Tools.timer(attack.vars["post_delay"],self),"timeout")

func load_attacks():
	for attack_path in attack_paths:
		var attack = load(attack_path).new()
		attacks.append(attack)

func choose_attack():
	if attacks.size() == 1:
		return attacks[0]
	var a = range(attacks.size())
	a.erase(attack_index)
	attack_index = a[randi()%a.size()]
	return attacks[attack_index]

func relocate_to(pos,time = 0.2) -> Tween:
	return Tools.tween(boss_node,"global_position",boss_node.global_position,pos,time)

		
func death():
	dying = true
	if next_phase and next_phase_condition():
		begin_next_phase()
		return
	animplayer.stop()
	
	relocate_to(Vector2(576, 220),0.2)
	animplayer.play("death")
	yield(animplayer,"animation_finished")
	destroy()

func destroy():
	queue_free()

func next_phase_condition():
	return true

func begin_next_phase():
	Audio.play_music(next_phase_sound,next_phase_sound_start)
	animplayer.play("next_phase")
	relocate_to(Vector2(576,244),0.2)
	yield(animplayer,"animation_finished")
	State.state["boss_phase"][boss_id] += 1
	Audio.seek(next_phase_sound_skip_at_end)
	spawn_next_phase()

func spawn_next_phase():
	var boss = next_phase.instance()
	get_parent().call_deferred("add_child",boss)
	queue_free()
	
