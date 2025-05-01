lang_add("EN", { 
	
	/*
	 Everything that comes after "//" is a comment and should not be translated
	 Only texts within "quotes" should be translated, except for names like "Gustavo Barros", "Dani Serranú", etc.
	
	With the intention of facilitating the translation of the poem, here are some observations.
	
	"comfort and sweetness of peace" is a concise piece of literature that serves as a metaphor for the cycles of life and death:
	
	"after the clouds, the sunshine",
	"after the winter, the spring",
	"after the shower, the rainbow",
	"for life is a changeable thing",
	"after the night, the morning",
	"bidding all darkness cease",
	"after life's cares and sorrows",
	"the comfort and sweetness of peace",
	
	
	Just as the clouds give way to sunshine, and the winter blossoms into spring, our own lives also experience ups and downs.
	Moonleap is a game that embodies these same themes, the poem is by far the most significant text in the entire game.
	
	When translating this poem, consider: meter and rhyme
	We have a set structure to work with: A, B, C, B, B, D, C, D.
	ine, ing, ow, ing, ing, ease, ows, eace
	
	This affords you some freedom in terms of adhering to a strict meter, but it's still worthwhile to try to maintain some consistency with the original
	While a direct translation may capture the meaning of the words, it can lose the beauty and musicality of the original
	
	Carefully choose words and phrasing that capture the feeling and tone of the poem, while also making sure the translated words fit into the structure
	Translating a poem is a delicate balance of preserving the original and creating something new and beautiful in the target language
	- Guselect and Miguel Mendes
	*/

	//              8b    d8    db    88  dP 888888 88""Yb 
	//              88b  d88   dPYb   88odP  88__   88__dP 
	//              88YbdP88  dP__Yb  88"Yb  88""   88"Yb  
	//              88 YY 88 dP""""Yb 88  Yb 888888 88  Yb 

maker_name: "level editor",
maker_play: "Test the Level",
maker_load: "Load Level",
maker_savemenu: "Save Level",
maker_menu: "Maker Menu",
maker_change_up: "Change Type (Up)",
maker_change_down: "Change Type (Down)",
maker_help: "Help",
maker_change_level_style: "Change Level Style",
maker_eraser: "Eraser",
maker_erase_level: "Erase the Level (Hold)",
maker_change_layer: "Change Layer",
maker_grassstyle: "Grass",
maker_cloudstyle: "Cloud",
maker_flowerstyle: "Flower",
maker_spacestyle: "Space",
maker_dungeonstyle: "Dungeon",

maker_menumakelevel: "Make Levels",

maker_noplayer: "You can't test without a player!",
maker_noestar: "You can't test without a star!",

maker_help_text: "Welcome to Moonleap Maker!\nClick on the objects and place them on the level\n\nKeyboard: \nZ - Rotate the object \nX - Mirror the object \nWASD or Arrow Keys - Navigate through the Object list \nF5 - Test the Level \n\nMouse: \nLeft Button - Place the Object \nRight Button - Erase Objects \nScroll - Change the type in the object list \nWe suggest limiting the screen loop to the player only\nOther objects may not behave as expected",

maker_intro: "Welcome to Moonleap Maker! This editor is in beta",

maker_foreground: "1: Foreground (Decoration)",
maker_objects: "2: Objects",
maker_background: "3: Background (Decoration)",
maker_far_background: "4: Far Background (Decoration)",


	//			d888888b d8b   db d888888b d8888b.  .d88b.  
	//			  `88'   888o  88 `~~88~~' 88  `8D .8P  Y8. 
	//			   88    88V8o 88    88    88oobY' 88    88 
	//			   88    88 V8o88    88    88`8b   88    88 
	//			  .88.   88  V888    88    88 `88. `8b  d8' 
	//			Y888888P VP   V8P    YP    88   YD  `Y88P'  
	
	text_guselect: "a game by guselect",
	skipintro : "press again to skip",
	text_poem1: "after the clouds, the sunshine",
	text_poem2: "after the winter, the spring",
	text_poem3: "after the shower, the rainbow",
	text_poem4: "for life is a changeable thing",
	text_poem5: "after the night, the morning",
	text_poem6: "bidding all darkness cease",
	text_poem7: "after life's cares and sorrows",
	text_poem8: "the comfort and sweetness of peace",
	
    text_shh: "shhhh",   //onomatopoeia for silence
    text_slower: "slower",   //onomatopoeia for silence
	
	//			.88b  d88. d88888b d8b   db db    db 
	//			88'YbdP`88 88'     888o  88 88    88 
	//			88  88  88 88ooooo 88V8o 88 88    88 
	//			88  88  88 88~~~~~ 88 V8o88 88    88 
	//			88  88  88 88.     88  V888 88b  d88 
	//			YP  YP  YP Y88888P VP   V8P ~Y8888P' 
	
	text_sure: "delete your save?",
	text_yes: "yes",
	text_no: "no",
	text_deletesave: "delete save data",
	text_savecaution: "this will erase all your game data\nthis action cannot be undone",
	text_holddown: "hold down to switch characters",
	
	text_ON: "on",
	text_OFF: "off",
	text_colorblind: "colorblind mode: ",
	text_music: "music: ",
	text_fullscreen: "fullscreen: ",
	text_windowscale: "window scale: ",
	text_soundvideo: "sound and video",
	text_sfx: "sfx: ",
	text_back: "back",
	text_start: "start game",
	text_options: "options",
	text_credits: "credits",
	text_exit: "exit",
	text_language: "language: ",
	text_assist: "assist mode", // This is where the game's accessibility options are located.
	text_speed: "game speed: ",
	text_full_colorblind: "adjust only if the normal mode\nmakes the game inaccessible for you", // "\n" is the code we use to create a line break. Any text that comes after it will appear on the next line.
	text_full_speed: "adjust only if the 100% speed\nmakes the game inaccessible for you",
	text_vibrate: "vibration: ",
	text_buttons: "show buttons: ",
		
	text_resume: "resume",
	text_changelevel: "change level",
	text_giveup: "go to menu",
		
	text_skip: "You can skip this level in the pause menu",
	
	//			 .o88b. d8888b. d88888b d8888b. d888888b d888888b .d8888. 
	//			d8P  Y8 88  `8D 88'     88  `8D   `88'   `~~88~~' 88'  YP 
	//			8P      88oobY' 88ooooo 88   88    88       88    `8bo.   
	//			8b      88`8b   88~~~~~ 88   88    88       88      `Y8b. 
	//			Y8b  d8 88 `88. 88.     88  .8D   .88.      88    db   8D 
	//			 `Y88P' 88   YD Y88888P Y8888D' Y888888P    YP    `8888Y' 
    
	// The credits may seem confusing as they are not in the order they appear in the game.
	// The translation of this passage works better when you are aware of how the game credits are organized.
	
	titulo: [
		"a game by",
		"music and sfx by",
		"additional programming by",
		"porting by",
		"additional level design (DLC) by",
	],
		
	nome: [
		"Gustavo Barros",
		"Dani Serranú",
		"Luiz Alves, Rowan Future and Daniel Neto",
		"James Begg",
		"Hugo Balthazar",
	],

	titulo_art: "cover art by",
	
	nomes_art: [
		"Aimee Cairns and João Alves \"Pyro\" (DLC)",
	],

	titulo_trans: "translated into english by",
	
	nomes_trans: [
		"Gustavo Barros",
	],

	titulo_tester: "tested by",

	nomes_testers1: [
		"Wave",
		"Rik",
		"Sundathree",
		"Sasha",
	],
	
	nomes_testers2: [
		"Breno Peua",
		"Vitória Nedel",
		"Opexe1",
		"Pre-DLC players",
	],

	titulo_agradecimentos: "special thanks",

nomes_agradecimento: [
	"Sr Pelo",
	"NamaTakahashi",
	"Moony Team",
	"Dani Serranú",
	"Garope",
	"Vitória Nedel",
	"Thomas",
	"Mom, Sister, and Julie (my dog)",
	"Miguel Mendes",
	"Isabel Marinho and GameMaker team",
],

//GameMaker should not be translated

agradecimento: [
	"kind permission to include Skid and Pump",
	"for lending us your character",
	"creation of Estrelano",
	"support and care for the game",
	"design of the first two creatures and support",
	"support for Gus",
	"support and kisses to Dani",
	"immense support over all these years",
	"translation of the poem and various bureaucracies",
	"incredible support and various opportunities",
],

// "support" here is in the sense of: "sometimes we argue, but I support"

agradecimento_extra: [
	"(watch Spooky Month)",
	"(play Elechead)",
	"(play Funky Moonleap)",
	"(text written by Gus)",
	"",
	"",
	"",
	"",
	"",
	"",
],

	titulo_obrigado: "also thanks to",
	
nomes_obrigado1: [
    "BeastlyChip",
    "DiogoTV",
    "BeastlyPi3tr0",
    "JulianoBeta",
    "Gabe Fern",
    "Daisuke Amaya",
    "Edmund Mcmillen",
    "Jonathan Blow",
    "Hempuli",
],

nomes_obrigado2: [
    "BeastlyMudoku",
    "goldenfoxy2604",
    "AnakimPlay",
    "BeastlyYoshiNG",
    "Saria Lemes",
    "#NoticeMe Game Jam",
    "Family and Friends",
    "My uncle Bobby",
    "You!",
],

	
	// Do not translate "#NoticeMe Game Jam".
	
	finais_titulo: [
		"art made in",
		"game created in",
		"poem by",
	],
	
	// Do not translate "Bard Audio Engine".
	
	finais_nome: [
		"Aseprite",
		"GameMaker",
		"Helen Steiner Rice",
	],
	
	// Do not translate "Aseprite" or "GameMaker". They are software names.

	agradecimento_final: "thank you for playing!",

	//			d8888b.  .d88b.   .d88b.  .88b  d88.      d8b   db  .d8b.  .88b  d88. d88888b .d8888. 
	//			88  `8D .8P  Y8. .8P  Y8. 88'YbdP`88      888o  88 d8' `8b 88'YbdP`88 88'     88'  YP 
	//			88oobY' 88    88 88    88 88  88  88      88V8o 88 88ooo88 88  88  88 88ooooo `8bo.   
	//			88`8b   88    88 88    88 88  88  88      88 V8o88 88~~~88 88  88  88 88~~~~~   `Y8b. 
	//			88 `88. `8b  d8' `8b  d8' 88  88  88      88  V888 88   88 88  88  88 88.     db   8D 
	//			88   YD  `Y88P'   `Y88P'  YP  YP  YP      VP   V8P YP   YP YP  YP  YP Y88888P `8888Y' 
	
	// Most of the level names provide hints on how to solve the stage.
	// If you have any doubts, please check the game or contact me.

	Room0: "1 - over the moon",		// As it is a pun, there is more freedom in choosing a name for this stage.	
	Room1: "2 - jump'n change",		// Keep the name of this stage as faithful as possible, as it serves as a kind of tutorial for the player.
	Room2: "3 - absurd",				// "Absurd" here is in the philosophical sense of the word, derived from absurdism.
	Room3: "4 - concrete leaves",
	Room4: "5 - leaves leaves",			// here happens a conversation with the previous stage name (which has leaves made with concrete).
	Room5: "6 - portal",				// It has this name because the top and "floor" of the game screen serve as portals, which is a hint.
	Room6: "7 - under the snails",		// It refers to a Brazilian song, so it is a pun, and you have more freedom in choosing a name that fits the context.
	Room7: "8 - no enemies",			// It has this name because the game has no enemies, and all creatures in the game also help the player.
	Room8: "9 - snail garden", 
	Room9: "10 - its alive",			// In this stage, an object that is usually still starts moving around, and the name comes from Frankenstein himself.
	Room10: "11 - head in the clouds",	// As it is a pun, there is more freedom in choosing a name for this stage.
	Room11: "12 - neither head nor tail",// This stage has neither a floor nor a ceiling, so it is a pun, so feel free to choose another name that fits the context.
	Room12: "13 - aerial fauna",
	Room13: "14 - back and forth",
	Room14: "15 - fragile",
	Room15: "16 - support",				// A creature in the game serves as a support for the player's feet in this stage, and the support here is in a physical sense.
	Room16: "17 - bad bugs",			// The name does not provide any hints, but I chose it because it sounds good. in Portuguese it is called "inseto no teto" (bugs on the celling)
	Room17: "18 - seeing stars",		// It is a pun, and to solve this stage, the player needs to headbutt a block.
	Room18: "19 - medusa",				// It has these names because this stage has creatures made of stone.
	Room19: "20 - insect ladder",
	Room20: "21 - turn and change!",
	Room21: "22 - life is a changeable thing", // It refers to the poem.
	Room22: "23 - misunderstanding",
	Room23: "24 - direction",			// The original (vira-vira) is a pun that only works on portuguese, there is more freedom in choosing a name for this stage.	
	Room24: "25 - over spikes",
	Room25: "26 - back to normal",
	Room26: "27 - first try",			// To complete this stage, at the beginning of it, the player already needs to know what they are doing and needs to pass it on the first try.
	Room27: "28 - $jumpscare$",
	Room28: "29 - gimme gimme",	//referring to the song. I add several references and jokes to make everything humorous.
	Room29: "30 - probably impossible",
	Room30: "31 - star dust",
	Room31: "32 - sideways",			//the name is humorous in Portuguese, there is more freedom in choosing a name for this stage
	Room32: "33 - revelation?",
	Room33: "34 - inevitable time",
	Room34: "35 - dance of shadows",
	Room35: "36 - no control",
	Room36: "37 - no space",
	Room37: "38 - no time",			// I would love for these three stages to continue with the same structure, rhyming with each other.
	Room38: "39 - trampoline",
	Room39: "40 - jump and change?",
	//DLC
	Room40: "#1?# - secret dungeon",
	Room41: "#2?# - watch your step", 
	Room42: "#3?# - trapdoor",
	Room43: "#4?# - level names aren't my thing", // Translate
	Room44: "#5?# - bat behind bars", // Translate
	Room45: "#6?# - magic orb",
    Room46: "#7?# - push-push",
    Room47: "#8?# - hitchhiker",                          
    Room48: "#9?# - key keeper",
    Room49: "#10?# - air jump",
	   //secret levels
    Room50: "#?# - labyrinth" ,
    Room51: "#?# - under snails",
    Room54: "#?# - headbutt",
    Room53: "#?# - flowers on the ceiling",
    Room52: "#?# - magic mushrooms",
    Room59: "#?# - right side",             
    Room58: "#?# - catch the crow",
    Room57: "#?# - boing boing",
    Room56: "#?# - direction prison",
    Room55: "#?# - good luck with this one",
    //final levels
    Room60: "@final@ - flashback",
    Room61: "@final@ - life sentence",
    Room62: "@final@ - inverting",
    Room63: "@final@ - took it for myself",


}
);


