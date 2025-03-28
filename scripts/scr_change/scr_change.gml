// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_change(){ 

	if instance_exists(oPlayer) {oPlayer.changecount+=1}
	if instance_exists(oMagicOrb) {oMagicOrb.change=true exit;} 

	if instance_exists(oBat) {oBat.change=true}
	if instance_exists(oKey) {oKey.change=true}
	if instance_exists(oKeyDoor) {oKeyDoor.change=true}
	if instance_exists(oBatVer) {oBatVer.change=true}
	if instance_exists(oSpecial1) {oSpecial1.change=true}

	//music_align()
	audio_play_sfx(snd_switch,false,-20.4,13)
	//if instance_exists(oBat) or instance_exists(oBatVer) {container_play( "SfxBatMove")}
	if instance_exists(oPlayer) {oPlayer.glow=true}
		
	if oCamera.night=true
	{
		oReactParent.night=false
			
		//oDust.sprite_index=sDUST

		with (oParentDay)   {ani=2 image_index=0 night=false}
		with (oSnail)		{ani=3 night=false}
		with (oSnailNight)  {ani=3 night=false}
		with (oParentNight) {ani=2 image_index=2 night=false}
	}
	else
	{	
		oReactParent.night=true
		//oDust.sprite_index=sDustNight

		with (oParentDay)   {ani=2 image_index=2 night=false}
		with (oSnail)		{ani=3 night=true}
		with (oSnailNight)  {ani=3 night=true}
		with (oParentNight) {ani=2 image_index=0 night=false}
		
		//if levelnumb<10 { oDust.sprite_index=sDustNight } else { oDust.sprite_index=sDustNightClouds }
	}
		
	//var actualnight=oCamera.night
		
	//Tilesets
		
	if instance_exists(oCloudDay)
	{
		lay_id = layer_get_id("Tiles_2");
		if (lay_id != -1) {
			tile_id = layer_tilemap_get_id(lay_id);

			if oCamera.night=true
			{tilemap_tileset(tile_id,tCloudNight)}
			else
			{tilemap_tileset(tile_id,tCloudDay)}
		}
	}
	
	if instance_exists(oGrassDay)
	{
		lay_id = layer_get_id("Tiles_Back");
		if (lay_id != -1) {
			tile_id = layer_tilemap_get_id(lay_id);

			if oCamera.night=true
			{tilemap_tileset(tile_id,tGrassNight)}
			else
			{tilemap_tileset(tile_id,tGrassDay)}
		}

		lay_id = layer_get_id("Tiles_Back_2");
		if (lay_id != -1) {
			tile_id = layer_tilemap_get_id(lay_id);

			if oCamera.night=true
			{tilemap_tileset(tile_id,tGrassNight)}
			else
			{tilemap_tileset(tile_id,tGrassDay)}
		}
			
		//Partículas
		shake_gamepad(0.4,2)
		repeat (choose(1,2)) {if place_meeting(x,y+1,oGrassDay) {instance_create_layer(x,y+(sprite_height/3),"Instances_2",oLeafDay)}} //folha		
		repeat (choose(1,2)) {if place_meeting(x,y+1,oGrassNight) {instance_create_layer(x,y+(sprite_height/3),"Instances_2",oLeafNight)}} //folha
	}
		
	if instance_exists(oSpaceDay)
	{
		lay_id = layer_get_id("Tiles_2");
		if (lay_id != -1) {
			tile_id = layer_tilemap_get_id(lay_id);

			if oCamera.night=true
			{tilemap_tileset(tile_id,tSpaceNight)}
			else
			{tilemap_tileset(tile_id,tSpaceDay)}
		}
	}
		
	if instance_exists(oDunDay)
	{
		lay_id = layer_get_id("Tiles_2");
		if (lay_id != -1) {
			tile_id = layer_tilemap_get_id(lay_id);

			if oCamera.night=true
			{tilemap_tileset(tile_id,tDungeon)}
			else
			{tilemap_tileset(tile_id,tDungeonDay)}
		}
	}
		
	if instance_exists(oFlowerDay)
	{
		if !instance_exists(oPlayerDir)
		{
		repeat (choose(1,2)) {if place_meeting(x,y+1,oFlowerDay) {instance_create_layer(x,y+(sprite_height/3),"Instances_2",oLeafDayFlower)}} //folha		
		repeat (choose(1,2)) {if place_meeting(x,y+1,oFlowerNight) {instance_create_layer(x,y+(sprite_height/3),"Instances_2",oLeafNightFlower)}} //folha
		}
	}
		
	if instance_exists(oWaterDust) { if oWaterDust.sprite_index=oBack.sprite_index {oWaterDust.image_index=oBack.image_index}}

	if oCamera.fancyeffects=true
	{
	with(oCamera) //dust
	{

		if instance_exists(oGrassDay)
		{
		if night=true {fx_set_parameter(layerfx,"param_sprite",sDustNight)} else {fx_set_parameter(layerfx,"param_sprite",sDUST)}
		}
		if instance_exists(oCloudDay)
		{
		if night=true {fx_set_parameter(layerfx,"param_sprite",sDustNightClouds)} else {fx_set_parameter(layerfx,"param_sprite",sDUST)}
		}
			
		if instance_exists(oFlowerDay)
		{
		if night=true {fx_set_parameter(layerfx,"param_sprite", sDustNightFlower)} else {fx_set_parameter(layerfx,"param_sprite", sDustFlower)}
		}
			
		if instance_exists(oSpaceDay)
		{
		if night=true {fx_set_parameter(layerfx,"param_sprite", sDustNightSpace)} else {fx_set_parameter(layerfx,"param_sprite", sDustSpace)}
		}
			
		if instance_exists(oDunDay) or  instance_exists(oDunNight)
		{
		if night=true {fx_set_parameter(layerfx,"param_sprite", sDustNightDun)} else {fx_set_parameter(layerfx,"param_sprite", sDustDun)}
		}


		if instance_exists(oPortal)
		{
		if night=true {fx_set_parameter(layerfx,"param_sprite",sDustHUB)} else {fx_set_parameter(layerfx,"param_sprite",sDustHUB)}
		}
	}
	}
	if instance_exists(oBack) {oBack.image_index=oCamera.night}
}
	
function scr_change_orb(){ 

		if instance_exists(oBat) {oBat.change=true}
		if instance_exists(oKey) {oKey.change=true}
		if instance_exists(oKeyDoor) {oKeyDoor.change=true}
		if instance_exists(oBatVer) {oBatVer.change=true}
		if instance_exists(oSpecial1) {oSpecial1.change=true}


//music_align()
audio_play_sfx(snd_switch,false,-20.4,13)
//if instance_exists(oBat) or instance_exists(oBatVer) {container_play( "SfxBatMove")}
	if instance_exists(oPlayer) {oPlayer.glow=true}
		
		if oCamera.night=true
		{
			oReactParent.night=false
			
			//oDust.sprite_index=sDUST

			with (oParentDay)   {ani=2 image_index=0 night=false}
			with (oSnail)		{ani=3}
			with (oSnailNight)  {ani=3}
			with (oParentNight) {ani=2 image_index=2 night=false}
		}
		else
		{
			
			oReactParent.night=true
			//oDust.sprite_index=sDustNight

			with (oParentDay)   {ani=2 image_index=2 night=false}
			with (oSnail)		{ani=3}
			with (oSnailNight)  {ani=3}
			with (oParentNight) {ani=2 image_index=0 night=false}
			
			
			
		
			//if levelnumb<10 { oDust.sprite_index=sDustNight } else { oDust.sprite_index=sDustNightClouds }
		}
		
		//var actualnight=oCamera.night
		
		//Tilesets
		
		if instance_exists(oCloudDay)
		{
			lay_id = layer_get_id("Tiles_2");
			if (lay_id != -1) {
				tile_id = layer_tilemap_get_id(lay_id);

				if oCamera.night=true
				{tilemap_tileset(tile_id,tCloudNight)}
				else
				{tilemap_tileset(tile_id,tCloudDay)}
			}
		}
	
		if instance_exists(oGrassDay)
		{
			lay_id = layer_get_id("Tiles_Back");
			if (lay_id != -1) {
				tile_id = layer_tilemap_get_id(lay_id);

				if oCamera.night=true
				{tilemap_tileset(tile_id,tGrassNight)}
				else
				{tilemap_tileset(tile_id,tGrassDay)}
			}

			lay_id = layer_get_id("Tiles_Back_2");
			if (lay_id != -1) {
				tile_id = layer_tilemap_get_id(lay_id);

				if oCamera.night=true
				{tilemap_tileset(tile_id,tGrassNight)}
				else
				{tilemap_tileset(tile_id,tGrassDay)}
			}
			
			//Partículas
			shake_gamepad(0.4,2)
			repeat (choose(1,2)) {if place_meeting(x,y+1,oGrassDay) {instance_create_layer(x,y+(sprite_height/3),"Instances_2",oLeafDay)}} //folha		
			repeat (choose(1,2)) {if place_meeting(x,y+1,oGrassNight) {instance_create_layer(x,y+(sprite_height/3),"Instances_2",oLeafNight)}} //folha
		}
		
		if instance_exists(oSpaceDay)
		{
			lay_id = layer_get_id("Tiles_2");
			if (lay_id != -1) {
				tile_id = layer_tilemap_get_id(lay_id);

				if oCamera.night=true
				{tilemap_tileset(tile_id,tSpaceNight)}
				else
				{tilemap_tileset(tile_id,tSpaceDay)}
			}
		}
		
		if instance_exists(oDunDay)
		{
			lay_id = layer_get_id("Tiles_2");
			if (lay_id != -1) {
				tile_id = layer_tilemap_get_id(lay_id);

				if oCamera.night=true
				{tilemap_tileset(tile_id,tDungeon)}
				else
				{tilemap_tileset(tile_id,tDungeonDay)}
			}
		}
		
		if instance_exists(oFlowerDay)
		{
			if !instance_exists(oPlayerDir)
			{
			repeat (choose(1,2)) {if place_meeting(x,y+1,oFlowerDay) {instance_create_layer(x,y+(sprite_height/3),"Instances_2",oLeafDayFlower)}} //folha		
			repeat (choose(1,2)) {if place_meeting(x,y+1,oFlowerNight) {instance_create_layer(x,y+(sprite_height/3),"Instances_2",oLeafNightFlower)}} //folha
			}
		}
		
		if instance_exists(oWaterDust) { if oWaterDust.sprite_index=oBack.sprite_index {oWaterDust.image_index=oBack.image_index}}
		if oCamera.fancyeffects=true
	{
		with(oCamera) //dust
		{

			if instance_exists(oGrassDay)
			{
			if night=true {fx_set_parameter(layerfx,"param_sprite",sDustNight)} else {fx_set_parameter(layerfx,"param_sprite",sDUST)}
			}
			if instance_exists(oCloudDay)
			{
			if night=true {fx_set_parameter(layerfx,"param_sprite",sDustNightClouds)} else {fx_set_parameter(layerfx,"param_sprite",sDUST)}
			}
			
			if instance_exists(oFlowerDay)
			{
			if night=true {fx_set_parameter(layerfx,"param_sprite", sDustNightFlower)} else {fx_set_parameter(layerfx,"param_sprite", sDustFlower)}
			}
			
			if instance_exists(oSpaceDay)
			{
			if night=true {fx_set_parameter(layerfx,"param_sprite", sDustNightSpace)} else {fx_set_parameter(layerfx,"param_sprite", sDustSpace)}
			}
			
			if instance_exists(oDunDay) or  instance_exists(oDunNight)
			{
			if night=true {fx_set_parameter(layerfx,"param_sprite", sDustNightDun)} else {fx_set_parameter(layerfx,"param_sprite", sDustDun)}
			}


			if instance_exists(oPortal)
			{
			if night=true {fx_set_parameter(layerfx,"param_sprite",sDustHUB)} else {fx_set_parameter(layerfx,"param_sprite",sDustHUB)}
			}
		}
	}
			if instance_exists(oBack) {oBack.image_index=oCamera.night}
}