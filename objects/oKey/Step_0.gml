wavevar=round(wave(-2,1,current_time/1000));

if change=true
{
	if		wide=true and tall=false	{instance_create_layer(x,y,layer,oKeyDoorWide)}
	else if tall=true and wide=false	{instance_create_layer(x,y,layer,oKeyDoorTall)}
	else if tall=true and wide=true	{instance_create_layer(x,y,layer,oKeyDoorTallWide)}
	else	{instance_create_layer(x,y,layer,oKeyDoor)}
	
	instance_destroy();
}

if place_meeting(x,y,oPlayer)
{
	oPlayer.key+=1
	var sfxcogu=choose(snd_key,snd_key2,snd_key3) audio_play_sfx(sfxcogu,false,-16,2)
	if oPlayer.key=1 {instance_create_layer(x,y,"Instances_2",oKeyFollow)}
	if oPlayer.key=2 {instance_create_layer(x,y,"Instances_2",oKeyFollow2)}
	if oPlayer.key=3 {instance_create_layer(x,y,"Instances_2",oKeyFollow3)}
	
	oPlayer.flash=1
	instance_destroy()
}