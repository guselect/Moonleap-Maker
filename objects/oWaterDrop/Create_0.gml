/// @description Insert description here
// You can write your code in this editor

image_index = random_range(0,10)
image_xscale = choose(-1,1)
grav=0.025

vsp=0
if instance_exists(oBack) {
  sprite_index = oBack.sprite_index;
} else if instance_exists(oLevelMaker) {
  var _drop_sprite = sBack;
  
  switch(oLevelMaker.selected_style) {
    case LEVEL_MAKER_STYLE.CLOUDS:
      sprite_index = sBackCloud;
    break;
  
    case LEVEL_MAKER_STYLE.FLOWERS:
      sprite_index = sBackFlower;
    break;
  
    case LEVEL_MAKER_STYLE.SPACE:
      sprite_index = sBackSpace;
    break;
  
    case LEVEL_MAKER_STYLE.DUNGEON:
      sprite_index = sBackDun;
    break;
  }
  sprite_index = _drop_sprite;
}
image_index=2
image_speed=0
vis=0


