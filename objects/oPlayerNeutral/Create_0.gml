
//instance_create_layer(x, y, layer, oNeutralFlag);
var _player = instance_create_layer(x, y, layer, oPlayer);
_player.mode = PLAYER_MODE.NEUTRAL;

instance_destroy();