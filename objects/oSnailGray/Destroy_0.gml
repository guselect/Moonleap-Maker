repeat(3) {
  instance_create_layer(x,y,"Instances_2",oBigSmoke)
}
audio_play_sfx(snd_kick,false,-7.3,13)
	
if instance_exists(oStar) {
  instance_destroy(oStar)
}
