extends Node2D

enum State {
	GoingAway,
	GoingTowards,
	Leaving
}

var target_position: Vector2

var state = State.GoingTowards

var segment_count: int = 80
var segment_length: float = 12.0
var segment_positions: Array
var segment_moved: Array

var collision_shapes: Array

func _ready():
	pass

func generate_positions(pos,direction=Vector2.ZERO):
	var current_position: Vector2 = pos
	for i in segment_count:
		segment_positions.append(current_position)
		segment_moved.append(false)
		var cs = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		cs.shape = shape
		shape.extents = body_texture.get_size()/2.0
		collision_shapes.append(cs)
		$DeathArea.add_child(cs)
		#current_position += direction*segment_length
	segment_moved[0] = true

var dir: Vector2 = Vector2.RIGHT
var rot: float = PI/2.0

var time: float = 0.0
var speed = 1300.0
var rotation_speed: float = 5.2
var c: int
func _physics_process(delta):
	time += delta
	dir = -Vector2.RIGHT.rotated(rot)
	segment_positions[0] += dir*speed*delta
	if time > 35.0:
		queue_free()
	var angle_to_center = segment_positions[0].angle_to_point((Vector2(576,324) + 4.0*Game.get_player().global_position)/5.0)
	var angle_to_player = segment_positions[0].angle_to_point(Game.get_player_position() + Vector2.UP*40.0)
	
	
	match state:
		State.GoingAway:
			rot -= rotate_towards(rot,angle_to_player,rotation_speed*1.6*delta)
			if segment_positions[0].distance_to(Game.get_player_position()) > 1700:
				state = State.GoingTowards
		State.GoingTowards:
			#if abs(angle_to_angle(rot,angle_to_player)) > 0.2:
			rot += sign(angle_to_angle(rot,angle_to_player))*rotation_speed*delta
			if segment_positions[0].distance_to(Game.get_player_position()) < 350:
				state = State.GoingAway
				
	
	collision_shapes[0].global_position = segment_positions[0]
	collision_shapes[0].rotation = segment_positions[0].angle_to_point(segment_positions[1])
	
	
	for i in range(1,segment_count):
		var old_pos = segment_positions[i]
		collision_shapes[i].global_position = segment_positions[i]
		collision_shapes[i].rotation = collision_shapes[i].global_position.angle_to_point(segment_positions[i-1])
		var dir = segment_positions[i-1].direction_to(segment_positions[i])
		var dist = segment_positions[i-1].distance_to(segment_positions[i])
		dist = clamp(dist,0,segment_length)
		segment_positions[i] = lerp(segment_positions[i],segment_positions[i-1]+dir*dist,30*delta)
		collision_shapes[i].global_position = segment_positions[i]
		if old_pos != segment_positions[i]:
			segment_moved[i] = true
	update()

func rotate_towards(angle1, angle2, delta):
	return sign(angle_to_angle(angle1,angle2))*delta
	
static func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI*2) - PI
	
func find_direction_to(pos):
	var angle_needed = segment_positions[0].angle_to_point(pos) + TAU
	var current_angle = dir.angle() + TAU
	return int(not lerp_angle(current_angle,angle_needed,0.02)>current_angle)*2-1
	

const head_texture = preload("res://bosses/pecinac/2/attacks/worm/head.png")
const body_texture = preload("res://bosses/pecinac/2/attacks/worm/body.png")
const tail_texture = preload("res://bosses/pecinac/2/attacks/worm/tail.png")

func _draw():
	draw_set_transform(segment_positions[0],segment_positions[0].angle_to_point(segment_positions[1]),Vector2.ONE)
	draw_texture(head_texture,-head_texture.get_size()/2.0)
	var ind = segment_count-1
	if segment_moved[ind]:
		var p = segment_positions[ind]
		draw_set_transform(p,p.angle_to_point(segment_positions[ind-1]),Vector2.ONE)
		draw_texture(tail_texture,-tail_texture.get_size()/2.0)
	for i in range(1,segment_count-1):
		if segment_moved[i]:
			draw_set_transform(segment_positions[i],segment_positions[i].angle_to_point(segment_positions[i-1]),Vector2.ONE)
			draw_texture(body_texture,-body_texture.get_size()/2.0)


func _on_DeathArea_body_entered(body):
	body.death()
