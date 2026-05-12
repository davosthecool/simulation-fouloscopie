extends CharacterBody2D


const SPEED : int = 100
const ATTRACTION_POWER : float = 5
const ALIGNMENT_POWER : float = 5
const REPULSION_POWER : float = 5

var direction : Vector2
var interactions_direction : Vector2

var agents_to_attract : Array
var agents_to_align : Array
var agents_to_repel : Array

func process_social_interactions() -> Vector2:
	var attraction_force : Vector2
	var repulsion_force : Vector2
	var alignment_force : Vector2
	
	for body in agents_to_attract:
		attraction_force += (body.position - position).normalized()
	
	for body in agents_to_align:
		alignment_force += body.direction.normalized()
	
	for body in agents_to_repel:
		repulsion_force -= (body.position - position).normalized()
	
	return ((attraction_force * ATTRACTION_POWER) + (alignment_force * ALIGNMENT_POWER) + (repulsion_force * REPULSION_POWER)).normalized()
		


func _init() -> void:
	direction = Vector2(1,1).rotated(randf_range(0, TAU)).normalized()
	position.x = randf_range(200.0,1000.0)
	position.y = randf_range(100.0,500.0)
	
	
func _physics_process(delta: float) -> void:
	interactions_direction = process_social_interactions()
	direction = (direction + interactions_direction).normalized()
	velocity = direction * SPEED
	move_and_slide()
	queue_redraw()
	
func _draw() -> void:
	draw_circle(Vector2.ZERO, 5, Color(1,0,0))
	draw_line(Vector2.ZERO, direction * 100, Color(0,1,0), 2)



func _on_attraction_circle_body_entered(body: Node2D) -> void:
	agents_to_attract.append(body)

func _on_attraction_circle_body_exited(body: Node2D) -> void:
	agents_to_attract.erase(body)

func _on_alignment_circle_body_entered(body: Node2D) -> void:
	agents_to_align.append(body)

func _on_alignment_circle_body_exited(body: Node2D) -> void:
	agents_to_align.erase(body)

func _on_repulsion_circle_body_entered(body: Node2D) -> void:
	agents_to_repel.append(body)

func _on_repulsion_circle_body_exited(body: Node2D) -> void:
	agents_to_repel.erase(body)
