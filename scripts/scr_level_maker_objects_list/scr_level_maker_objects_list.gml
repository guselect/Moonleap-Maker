/// @desc Returns an object array of `LMObject` objects that is used to display on Level Editor in buttons.
function level_maker_get_objects_list() {
	var _objects = [];
	
  // ==============================
  // Page 1
  // ==============================
  
	_objects[0, 00] =	new LMObject(oPlayer)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("is_unique", "is_player")
    .set_button_sprite_draw_config(sPlayerIdle, 10, 0, 0, -7, -10, 15, 19);
  _objects[0, 00].on_begin_draw_button_sprite = function() {
      var _palette = sPlayerPal,
          _palette_index = 0,
          _is_surface = false;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          _palette_index = 2;
        break;
      }
    
      pal_swap_set(_palette, _palette_index, _is_surface);
    };
  _objects[0, 00].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[0, 00].on_begin_draw_preview_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 0,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          _palette_index = 2;
        break;
      }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 00].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[0, 01] =	new LMObject(oSolid)
    .set_size(16, 16)
    .add_tag("grid_16", "is_holdable")
    .set_button_sprite_draw_config(sBlockGray, 0, 0, 0, 0, 0);
  _objects[0, 01].on_begin_draw_button_sprite = method(
    { main: _objects[0, 01] }, 
    function() {
      main.button_sprite_image_index = 0;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          main.button_sprite_image_index = 5;
        break;
      }
    }
  );
  _objects[0, 01].on_begin_draw_preview_sprite = function() {
    var _frame = 0;
    
    switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          _frame = 5;
        break;
      }
    
    return {
      frame: _frame
    };
  };
  
	_objects[0, 02] =	new LMObject(oBrokenStone)
    .set_size(16, 16)
    .add_tag("grid_16", "is_holdable")
    .set_button_sprite_draw_config(sBrokenStone, 0, 0, 0, 0, 0);
  _objects[0, 02].on_begin_draw_button_sprite = method(
    { main: _objects[0, 02] }, 
    function() {
      main.button_sprite_image_index = 0;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          main.button_sprite_image_index = 1;
        break;
      }
    }
  );
  _objects[0, 02].on_begin_draw_preview_sprite = function() {
    var _frame = 0;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _frame = 1;
      break;
    }
    
    return {
      frame: _frame
    };
  };
  
	_objects[0, 03] =	new LMObject(oPlatGhost)
    .set_size(16, 16)
    .add_tag("can_spin")
    .set_button_sprite_draw_config(sBlockGhost, 0, 0, 0, 0, 0);
  _objects[0, 03].on_begin_draw_button_sprite = method(
    { main: _objects[0, 03] }, 
    function() {
      main.button_sprite_image_index = 0;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          main.button_sprite_image_index = 1;
        break;
      }
    }
  );
  _objects[0, 03].on_begin_draw_preview_sprite = function() {
    var _frame = 0;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _frame = 1;
      break;
    }
    
    return {
      frame: _frame
    };
  };
  
	_objects[0, 04] =	new LMObject(oSolidRamp)
    .set_size(32, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sBlockRampEditor, 0, 16, 0, -8, -8);
  _objects[0, 04].on_begin_draw_button_sprite = method(
    { main: _objects[0, 04] }, 
    function() {
      main.button_sprite_sprite_index = sBlockRampEditor;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          main.button_sprite_sprite_index = sBlockRampMaskDark;
        break;
      }
    }
  );
  _objects[0, 04].on_begin_draw_preview_sprite = function() {
    var _frame = 0;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _frame = 8;
      break;
    }
    
    return {
      frame: _frame
    };
  };
  
	_objects[0, 05] =	new LMObject(oPermaSpike)
    .set_size(16, 16)
    .add_tag("is_holdable")
    .set_button_sprite_draw_config(sPermaSpike, 0, 0, 0, 0, 0);
  _objects[0, 05].on_begin_draw_button_sprite = method(
    { main: _objects[0, 05] },
    function() {
      main.button_sprite_image_index = 0;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          main.button_sprite_image_index = 1;
        break;
      }
    }
  );
  _objects[0, 05].on_begin_draw_preview_sprite = function() {
    var _frame = 0;
    
    switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          _frame = 1;
        break;
      }
    
    return {
      frame: _frame
    };
  };
  
	_objects[0, 06] =	new LMObject(oSolidDay)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.OFFSET5)
    .add_tag("grid_16", "is_holdable", "can_spin")
    .set_colorblind_icon_frame(0)
    .set_button_sprite_draw_config(sGrassGre, 0, 8, 8, 0, 0);
  _objects[0, 06].on_begin_draw_button_sprite = method(
    { main: _objects[0, 06] }, 
    function() {
      var _sprite = sGrassGre;
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.CLOUDS:
          _sprite = sCloudDay;
        break;
        case LEVEL_MAKER_STYLE.FLOWERS:
          _sprite = sFlowerDay;
        break;
        case LEVEL_MAKER_STYLE.SPACE:
          _sprite = sSpaceGre;
        break;
        case LEVEL_MAKER_STYLE.DUNGEON:
          _sprite = sDunDay;
        break;
      }
      
      main.button_sprite_sprite_index = _sprite;
    }
  );
  _objects[0, 06].on_begin_draw_preview_sprite = function() {
    var _sprite = sGrassGre;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.CLOUDS:
        _sprite = sCloudDay;
      break;
      case LEVEL_MAKER_STYLE.FLOWERS:
        _sprite = sFlowerDay;
      break;
      case LEVEL_MAKER_STYLE.SPACE:
        _sprite = sSpaceGre;
      break;
      case LEVEL_MAKER_STYLE.DUNGEON:
        _sprite = sDunDay;
      break;
    }
    
    return {
      sprite: _sprite
    };
  };
  
	_objects[0, 07] =	new LMObject(oSolidNight)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.OFFSET5)
    .add_tag("grid_16", "is_holdable", "can_spin")
    .set_colorblind_icon_frame(1)
    .set_button_sprite_draw_config(sGrassGre, 0, 8, 8, 0, 0);
  _objects[0, 07].on_begin_draw_button_sprite = method(
    { main: _objects[0, 07] }, 
    function() {
      var _sprite = sGrassOre;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.CLOUDS:
          _sprite = sCloudNight;
        break;
        case LEVEL_MAKER_STYLE.FLOWERS:
          _sprite = sFlowerNight;
        break;
        case LEVEL_MAKER_STYLE.SPACE:
          _sprite = sSpacePurple;
        break;
        case LEVEL_MAKER_STYLE.DUNGEON:
          _sprite = sDunNight;
        break;
      }
      
      main.button_sprite_sprite_index = _sprite;
    }
  );
  _objects[0, 07].on_begin_draw_preview_sprite = function() {
    var _sprite = sGrassOre,
        _frame = 2;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.CLOUDS:
        _sprite = sCloudNight;
      break;
      case LEVEL_MAKER_STYLE.FLOWERS:
        _sprite = sFlowerNight;
      break;
      case LEVEL_MAKER_STYLE.SPACE:
        _sprite = sSpacePurple;
      break;
      case LEVEL_MAKER_STYLE.DUNGEON:
        _sprite = sDunNight;
      break;
    }
    
    return {
      sprite: _sprite,
      frame: _frame
    };
  };
  
	_objects[0, 08] =	new LMObject(oLadderDay)
    .set_size(16, 16)
    .set_colorblind_icon_frame(0)
    .set_button_sprite_draw_config(sLadderDay, 0, 0, 0, 0, 0);
  _objects[0, 08].on_begin_draw_button_sprite = method(
    { main: _objects[0, 08] }, 
    function() {
      var _palette = sLadderPal,
          _palette_index = oLevelMaker.selected_style,
          _is_surface = false;
      
      pal_swap_set(_palette, _palette_index, _is_surface);
    }
  );
  _objects[0, 08].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[0, 08].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 08].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[0, 09] =	new LMObject(oLadderNight)
    .set_size(16, 16)
    .set_colorblind_icon_frame(1)
    .set_button_sprite_draw_config(sLadderNight, 0, 0, 0, 0, 0);
  _objects[0, 09].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 09].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[0, 09].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 09].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[0, 10] =	new LMObject(oStar)
    .set_size(16, 16)
    .add_tag("can_spin");
  _objects[0, 10].on_begin_draw_button_sprite = method(
    { main: _objects[0, 10] },
    function() {
      main.button_sprite_sprite_index = sStar;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          main.button_sprite_sprite_index = sStarFlower;
        break;
      }
    }
  );
  _objects[0, 10].on_begin_draw_preview_sprite = function() {
    var _sprite = sStar;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _sprite = sStarFlower;
      break;
    }
    
    return {
      sprite: _sprite
    };
  };
  _objects[0, 10].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[0, 11] =	new LMObject(oStarRunning)
    .set_size(16, 16);
  
	_objects[0, 12] =	new LMObject(oSnail)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sSnailWalk, 0, 0, 2, -9, 0);
  _objects[0, 12].on_begin_draw_button_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 12].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[0, 12].on_begin_draw_preview_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 12].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[0, 13] =	new LMObject(oSnailNight)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sSnailIdleNight, 0, 0, 2, -11, 0, 18);
  _objects[0, 13].on_begin_draw_button_sprite = function() {
      var _palette = sSnailPal,
          _palette_index = oLevelMaker.selected_style,
          _is_surface = false;
      
      pal_swap_set(_palette, _palette_index, _is_surface);
    };
  _objects[0, 13].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[0, 13].on_begin_draw_preview_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 13].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[0, 14] =	new LMObject(oLady)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sLady, 0, 3, 0, -8, -8);
  _objects[0, 14].on_begin_draw_button_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 14].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[0, 14].on_begin_draw_preview_sprite = function(_xscale) {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false,
        _frame = _xscale == -1 ? 1 : 0;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
    
    return {
      frame: _frame,
      xscale: 1
    };
  };
  _objects[0, 14].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[0, 15] =	new LMObject(oBat)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip", "grid_16")
    .set_button_sprite_draw_config(sBat, 0, 10, 4, -7, -8);
	_objects[0, 15].on_begin_draw_button_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 15].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[0, 15].on_begin_draw_preview_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[0, 15].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
  // ==============================
  // Page 2
  // ==============================
  
	_objects[1, 00] =	new LMObject(oPlayerDir)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("is_unique", "is_player")
    .set_button_sprite_draw_config(sPlayerRun, 1, 0, 0, -7, -10, 15, 19);
  _objects[1, 00].on_begin_draw_button_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 0,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 2;
      break;
    }
  
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 00].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 00].on_begin_draw_preview_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 0,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 2;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 00].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 01] =	new LMObject(oBigSolid)
    .set_size(32, 32)
    .add_tag("grid_16", "is_holdable")
    .set_button_sprite_draw_config(sBlockGrayGiant, 0, 0, 0, 0, 0);
  _objects[1, 01].on_begin_draw_button_sprite = method(
    { main: _objects[1, 01] }, 
    function() {
      main.button_sprite_image_index = 0;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          main.button_sprite_image_index = 5;
        break;
      }
    }
  );
  _objects[1, 01].on_begin_draw_preview_sprite = function() {
    var _frame = 0;
    
    switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          _frame = 5;
        break;
      }
    
    return {
      frame: _frame
    };
  };
  
	_objects[1, 02] =	new LMObject(oBrokenStoneBig)
    .set_size(32, 32)
    .add_tag("grid_16", "is_holdable")
    .set_button_sprite_draw_config(sBrokenStoneBig, 0, 0, 0, 0, 0);
  _objects[1, 02].on_begin_draw_button_sprite = method(
    { main: _objects[1, 02] }, 
    function() {
      main.button_sprite_image_index = 0;
      
      switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          main.button_sprite_image_index = 1;
        break;
      }
    }
  );
  _objects[1, 02].on_begin_draw_preview_sprite = function() {
    var _frame = 0;
    
    switch(oLevelMaker.selected_style) {
        case LEVEL_MAKER_STYLE.FLOWERS:
        case LEVEL_MAKER_STYLE.SPACE:
        case LEVEL_MAKER_STYLE.DUNGEON:
          _frame = 1;
        break;
      }
    
    return {
      frame: _frame
    };
  };
  
	_objects[1, 03] =	new LMObject(oLadderNeutral)
    .set_size(16, 16)
    .set_button_sprite_draw_config(sLadderNeutral, 0, 0, 0, 0, 0);
  _objects[1, 03].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = 0,
        _is_surface = false;
  
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 8;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 03].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 03].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = 0,
        _is_surface = false;
  
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 8;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 03].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 04] =	new LMObject(oStarColor)
    .set_size(16, 16);
  
	_objects[1, 05] =	new LMObject(oStarRunningColor)
    .set_size(16, 16);
  
	_objects[1, 06] =	new LMObject(oMush)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_spin")
    .set_button_sprite_draw_config(sSuperMush, 0, 0, 0, 0, 0);
	_objects[1, 06].on_begin_draw_button_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 0,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 2;
      break;
    }
  
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 06].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 06].on_begin_draw_preview_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 0,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 2;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 06].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 07] =	new LMObject(oMushGray)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_spin")
    .set_button_sprite_draw_config(sMushGrayUI, 0, 0, 0, 0, 0);
  _objects[1, 07].on_begin_draw_button_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 0,
        _is_surface = false;
  
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 5;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 07].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 07].on_begin_draw_preview_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 0,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 5;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 07].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 08] =	new LMObject(oSnailGray)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sSnalGrayMask, 0, 0, 0, -13, -2, 26, 18);
  _objects[1, 08].on_begin_draw_button_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = 6,
        _is_surface = false;
  
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 7;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 08].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 08].on_begin_draw_preview_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = 6,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 7;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 08].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 09] =	new LMObject(oLadyGray)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sLadyGrayUI, 0, 3, 0, -8, -8);
  _objects[1, 09].on_begin_draw_button_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = 6,
        _is_surface = false;
  
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 7;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 09].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 09].on_begin_draw_preview_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = 6,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 7;
      break;
    }
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 09].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 10] =	new LMObject(oLadyVer)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip", "is_vertical")
    .set_button_sprite_draw_config(sLadyVerUI, 0, 3, 1, -8, -8);
  _objects[1, 10].on_begin_draw_button_sprite = function() {
      var _palette = sSnailPal,
          _palette_index = oLevelMaker.selected_style,
          _is_surface = false;
      
      pal_swap_set(_palette, _palette_index, _is_surface);
    };
  _objects[1, 10].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 10].on_begin_draw_preview_sprite = function(_, _yscale) {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false,
        _frame = _yscale == -1 ? 1 : 0;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
    
    return {
      frame: _frame,
      yscale: 1
    }
  };
  _objects[1, 10].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 11] =	new LMObject(oLadyGiant)
    .set_size(48, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sLadyGiant, 0, 19, 1, -8, -8);
  _objects[1, 11].on_begin_draw_button_sprite = function() {
      var _palette = sSnailPal,
          _palette_index = oLevelMaker.selected_style,
          _is_surface = false;
      
      pal_swap_set(_palette, _palette_index, _is_surface);
    };
  _objects[1, 11].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 11].on_begin_draw_preview_sprite = function(_xscale) {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false,
        _frame = _xscale == -1 ? 1 : 0;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
    
    return {
      frame: _frame,
      xscale: 1
    };
  };
  _objects[1, 11].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 12] =	new LMObject(oLadyGiant4)
    .set_size(64, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sLadyGiant4, 0, 14, 1, -8, -8);
  _objects[1, 12].on_begin_draw_button_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 12].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 12].on_begin_draw_preview_sprite = function(_xscale) {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false,
        _frame = _xscale == -1 ? 1 : 0;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
    
    return {
      frame: _frame,
      xscale: 1
    };
  };
  _objects[1, 12].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 13] =	new LMObject(oBatVer)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip", "grid_16", "is_vertical")
    .set_button_sprite_draw_config(sBatDown, 0, 10, 4, -7, -8);
  _objects[1, 13].on_begin_draw_button_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 13].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 13].on_begin_draw_preview_sprite = function(_, _yscale) {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false,
        _sprite = _yscale == -1 ? sBatUp : sBatDown;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
    
    return {
      sprite: _sprite,
      yscale: 1
    };
  };
  _objects[1, 13].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 14] =	new LMObject(oBatGiant)
    .set_size(48, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sBatGiant, 0, 21, 1, -8, -8);
  _objects[1, 14].on_begin_draw_button_sprite = function() {
      var _palette = sSnailPal,
          _palette_index = oLevelMaker.selected_style,
          _is_surface = false;
      
      pal_swap_set(_palette, _palette_index, _is_surface);
    };
  _objects[1, 14].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 14].on_begin_draw_preview_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 14].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[1, 15] =	new LMObject(oBatSuperGiant)
    .set_size(64, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sBatGiant4, 0, 12, 1, -8, -8);
  _objects[1, 15].on_begin_draw_button_sprite = function() {
      var _palette = sSnailPal,
          _palette_index = oLevelMaker.selected_style,
          _is_surface = false;
      
      pal_swap_set(_palette, _palette_index, _is_surface);
    };
  _objects[1, 15].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[1, 15].on_begin_draw_preview_sprite = function() {
    var _palette = sSnailPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[1, 15].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
	
  // ==============================
  // Page 3
  // ==============================
  
	_objects[2, 00] =	new LMObject(oPlayerNeutral)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("is_unique", "is_player")
    .set_button_sprite_draw_config(sPlayerSit, sprite_get_number(sPlayerSit) - 1, 0, 0, -7, -10, 15, 19);
  _objects[2, 00].on_begin_draw_button_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 5,
        _is_surface = false;

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 00].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 00].on_begin_draw_preview_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 5,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 00].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 01] =	new LMObject(oBird)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_flip", "is_unique");
  
	_objects[2, 02] =	new LMObject(oKey)
    .set_size(16, 16)
    .set_button_sprite_draw_config(sKey, 0, 0, 0, -8, -8);
  _objects[2, 02].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 02].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 02].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 02].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 03] =	new LMObject(oKeyDoor)
    .set_size(16, 16)
    .set_button_sprite_draw_config(sKeyDoor, 0, 0, 0, -8, -8);
  _objects[2, 03].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 03].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 03].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 03].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 04] =	new LMObject(oKeyTall)
    .set_size(16, 32)
    .set_button_sprite_draw_config(sKeyDoorTallUI, 0, 0, 8, -8, -8);
  _objects[2, 04].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 04].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 04].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 04].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 05] =	new LMObject(oKeyDoorTall)
    .set_size(16, 32)
    .set_button_sprite_draw_config(sKeyDoorTall, 0, 0, 8, -8, -8);
  _objects[2, 05].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 05].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 05].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 05].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 06] =	new LMObject(oKeyWide)
    .set_size(32, 16)
    .set_button_sprite_draw_config(sKeyDoorWideUI, 0, 8, 0, -8, -8);
  _objects[2, 06].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 06].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 06].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 06].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 07] =	new LMObject(oKeyDoorWide)
    .set_size(32, 16)
    .set_button_sprite_draw_config(sKeyDoorWide, 0, 8, 0, -8, -8);
  _objects[2, 07].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 07].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 07].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 07].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 08] =	new LMObject(oKeyTallWide)
    .set_size(32, 32)
    .set_button_sprite_draw_config(sKeyDoorTallWideUI, 0, 0, 0, -8, -8);
  _objects[2, 08].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 08].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 08].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 08].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 09] =	new LMObject(oKeyDoorTallWide)
    .set_size(32, 32)
    .set_button_sprite_draw_config(sKeyDoorWideTall, 0, 0, 0, -8, -8);
  _objects[2, 09].on_begin_draw_button_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;
    
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 09].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 09].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = oLevelMaker.selected_style,
        _is_surface = false;

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 09].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 10] =	new LMObject(oMagicOrb)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("is_unique", "is_orb")
    .set_button_sprite_draw_config(sGemFly, 0, 0, 0, -7, -6, 15, 19);
  _objects[2, 10].on_begin_draw_button_sprite = function() {
    var _palette = sPlayerPal,
        _palette_index = 0,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 2;
      break;
    }
  
    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 10].on_end_draw_button_sprite = function() {
    pal_swap_reset();
  };
  _objects[2, 10].on_begin_draw_preview_sprite = function() {
    var _palette = sLadderPal,
        _palette_index = 0,
        _is_surface = false;
    
    switch(oLevelMaker.selected_style) {
      case LEVEL_MAKER_STYLE.FLOWERS:
      case LEVEL_MAKER_STYLE.SPACE:
      case LEVEL_MAKER_STYLE.DUNGEON:
        _palette_index = 2;
      break;
    }

    pal_swap_set(_palette, _palette_index, _is_surface);
  };
  _objects[2, 10].on_end_draw_preview_sprite = function() {
    pal_swap_reset();
  };
  
	_objects[2, 11] =	new LMObject(oStarFly)
    .set_size(16, 16);
  
	_objects[2, 12] =	new LMObject(oSolidInv)
    .set_size(16, 16)
    .add_tag("grid_16", "is_holdable");
  
	_objects[2, 13] =	undefined;
  
	_objects[2, 14] =	undefined;
  
	_objects[2, 15] =	undefined;

	return _objects;
}
