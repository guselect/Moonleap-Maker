if instance_exists(oRoomTransition) or not visible then exit;

var xx = random_range(x,x+16)
var yy = random_range(y,y+16)

instance_create_layer(xx, yy, "Instances_2", oSpark)
neww = false;