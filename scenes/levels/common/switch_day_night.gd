var day_group;
var night_group;
var main_node: Node


func init(node: Node):
	main_node = node
	day_group = main_node.get_tree().get_nodes_in_group("Group_Day")
	night_group = main_node.get_tree().get_nodes_in_group("Group_Night")
	
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func switch_to_day():
	for node_day in day_group:
		node_day.visible = true
	for node_night in night_group:
		node_night.visible = false

	

func switch_to_night():
	for node_day in day_group:
		node_day.visible = false
	for node_night in night_group:
		node_night.visible = true
