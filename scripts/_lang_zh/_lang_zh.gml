lang_add("ZH", { 
                                                                                                                                                                              
	//	Tudo que estiver logo após "//" é um comentário e não deve ser traduzido
	//	Somente os textos dentro de "aspas" devem ser traduzidos, com exceção de nomes, como "Gustavo Barros", "Dani Serranú" etc
	//	Antes de tudo, segue aqui o poema em seu idioma original,:
	
	//	"after the clouds, the sunshine",
	//	"after the winter, the spring",
	//	"after the shower, the rainbow",
	//	"for life is a changeable thing",
	//	"after the night, the morning",
	//	"bidding all darkness cease",
	//	"after life's cares and sorrows",
	//	"the comfort and sweetness of peace",

	
	// Com o intuito de facilitar a tradução do poema, aqui estão algumas observações.

	// "comfort and sweetness of peace" é uma peça literária concisa que serve como metáfora para os ciclos da vida e da morte.
	// Assim como as nuvens dão lugar ao sol e o inverno floresce na primavera, nossas vidas também passam por altos e baixos.
	// Moonleap é um jogo que incorpora esses mesmos temas, o poema é de longe o texto mais importante de todo o jogo.

	// Ao traduzir este poema, há dois elementos-chave a serem considerados: métrica e rima
	// Temos uma estrutura definida para trabalhar: A, B, C, B, B, D, C, D.
	// ine, ing, ow, ing, ing, eace, ow, eace
	// Isso oferece certa liberdade em relação a aderir a uma métrica estrita, mas ainda assim é importante manter alguma consistência com o original.
	// Embora uma tradução direta possa capturar o significado das palavras, pode perder a beleza e a musicalidade do original.

	// Escolha cuidadosamente palavras e frases que capturem o sentimento e tom do poema, enquanto também garante que as palavras traduzidas se encaixem na estrutura.
	// Traduzir um poema é um delicado equilíbrio entre preservar o original e criar algo novo e bonito no idioma de destino.
	// - Guselect (dev) e Miguel Mendes (escritor)
	
	
	

	//			d888888b d8b   db d888888b d8888b.  .d88b.  
	//			  `88'   888o  88 `~~88~~' 88  `8D .8P  Y8. 
	//			   88    88V8o 88    88    88oobY' 88    88 
	//			   88    88 V8o88    88    88`8b   88    88 
	//			  .88.   88  V888    88    88 `88. `8b  d8' 
	//			Y888888P VP   V8P    YP    88   YD  `Y88P'  
    

	text_guselect: "guselect制作的游戏", // "a game by guselect"
	skipintro: "再按一次以跳过", // "press again to skip"
	
	text_poem1:"云后是阳光",
	text_poem2:"冬去春又来",
	text_poem3:"雨后现彩虹",
	text_poem4:"生命多变换",
	text_poem5:"夜晚过晨明",
	text_poem6:"暗影全消散",
	text_poem7:"烦忧终将过",
	text_poem8:"安慰甜蜜安",
	
  text_shh: "嘘", // "shhhh"
  text_slower: "慢一点", // "slower"
  
  //      8b    d8    db    88  dP 888888 88""Yb 
  //      88b  d88   dPYb   88odP  88__   88__dP 
  //      88YbdP88  dP__Yb  88"Yb  88""   88"Yb  
  //      88 YY 88 dP""""Yb 88  Yb 888888 88  Yb 
  maker_name: "关卡编辑器",
  maker_play: "测试关卡",
  maker_load: "加载关卡",
  maker_savemenu: "保存关卡",
  maker_menu: "编辑器菜单",
  maker_change_up: "更改类型（上）",
  maker_change_down: "更改类型（下）",
  maker_help: "帮助",
  maker_change_level_style: "更改关卡风格",
  maker_eraser: "橡皮擦",
  maker_erase_level: "清空关卡（按住）",
  maker_change_layer: "切换图层",
  maker_grassstyle: "草地",
  maker_cloudstyle: "云朵",
  maker_flowerstyle: "花卉",
  maker_spacestyle: "太空",
  maker_dungeonstyle: "地牢",
  
  maker_menumakelevel: "制作关卡",
  
  maker_noplayer: "没有玩家，无法测试！",
  maker_noestar: "没有星星，无法测试！",
  
  maker_help_text: "欢迎来到 Moonleap Maker！\n点击对象并将它们放置在关卡中\n\n键盘：\nZ - 旋转对象\nX - 镜像对象\nWASD 或方向键 - 在对象列表中导航\nF5 - 测试关卡\n\n鼠标：\n左键 - 放置对象\n右键 - 删除对象\n滚轮 - 更改对象列表中的类型\n建议将屏幕循环限制为仅限玩家\n其他对象可能无法按预期运行",
  
  maker_intro: "欢迎来到 Moonleap Maker！此编辑器处于测试版",
  
  maker_foreground: "1: 前景（装饰）",
  maker_objects: "2: 物体",
  maker_background: "3: 背景（装饰）",
  maker_far_background: "4: 远景背景（装饰）",

  maker_object_oPlayer: "球员",
  maker_object_oSolid: "实心块",
  maker_object_oBrokenStone: "破碎的石头",
  maker_object_oPlatGhost: "平台",
  maker_object_oSolidRamp: "坡道",
  maker_object_oPermaSpike: "长钉",
  maker_object_oSolidDay: "日固体块",
  maker_object_oSolidNight: "夜坚实的块",
  maker_object_oLadderDay: "一日爬行者",
  maker_object_oLadderNight: "夜间爬行者",
  maker_object_oStar: "星星",
  maker_object_oStarRunning: "跑步之星",
  maker_object_oSnail: "蜗牛",
  maker_object_oSnailNight: "夜蜗牛",
  maker_object_oLady: "瓢虫",
  maker_object_oBat: "蝙蝠",
  maker_object_oPlayerDir: "方向播放器",
  maker_object_oBigSolid: "大固体",
  maker_object_oBrokenStoneBig: "大碎石",
  maker_object_oLadderNeutral: "中性爬行者",
  maker_object_oStarColor: "红星",
  maker_object_oStarRunningColor: "奔跑红星",
  maker_object_oMush: "蘑菇",
  maker_object_oMushGray: "中性蘑菇",
  maker_object_oSnailGray: "中性蜗牛",
  maker_object_oLadyGray: "中立的瓢虫",
  maker_object_oLadyVer: "垂直瓢虫",
  maker_object_oLadyGiant: "三重瓢虫",
  maker_object_oLadyGiant4: "四瓢虫",
  maker_object_oBatVer: "垂直蝙蝠",
  maker_object_oBatGiant: "三蝙蝠",
  maker_object_oBatSuperGiant: "四杆蝙蝠",
  maker_object_oPlayerNeutral: "中立球员",
  maker_object_oBird: "鸟",
  maker_object_oKey: "钥匙",
  maker_object_oKeyDoor: "门",
  maker_object_oKeyTall: "高钥匙",
  maker_object_oKeyDoorTall: "高高的门",
  maker_object_oKeyWide: "宽钥匙",
  maker_object_oKeyDoorWide: "宽门",
  maker_object_oKeyTallWide: "大钥匙",
  maker_object_oKeyDoorTallWide: "大门",
  maker_object_oMagicOrb: "魔术球",
  maker_object_oStarFly: "飞星",
  maker_object_oSolidInv: "隐形实心块",


	
	//			.88b  d88. d88888b d8b   db db    db 
	//			88'YbdP`88 88'     888o  88 88    88 
	//			88  88  88 88ooooo 88V8o 88 88    88 
	//			88  88  88 88~~~~~ 88 V8o88 88    88 
	//			88  88  88 88.     88  V888 88b  d88 
	//			YP  YP  YP Y88888P VP   V8P ~Y8888P' 
    
	
text_sure: "确定删除存档？", // "delete your save?"
text_yes: "是", // "yes"
text_no: "否", // "no"
text_deletesave: "删除存档数据", // "delete save data"
text_savecaution: "这将清除您的所有游戏数据\n此操作无法撤销", // "this will erase all your game data\nthis action cannot be undone"
text_holddown:"按住向下键以更换角色",

text_ON: "开", // "on"
text_OFF: "关", // "off"
text_colorblind: "色盲模式：", // "colorblind mode: "
text_music: "音乐：", // "music: "
text_fullscreen: "全屏：", // "fullscreen: "
text_windowscale: "窗口缩放：", // "window scale: "
text_soundvideo: "声音和视频", // "sound and video"
text_sfx: "音效：", // "sfx: "
text_back: "返回", // "back"
text_start: "开始游戏", // "start game"
text_options: "选项", // "options"
text_credits: "制作团队", // "credits"
text_exit: "退出", // "exit"
text_language: "语言：", // "language: "
text_assist: "辅助模式", // "assist mode"
text_speed: "游戏速度：", // "game speed: "
text_full_colorblind: "仅在普通模式\n对您不可访问时调整", // "adjust only if the normal mode\nmakes the game inaccessible for you"
text_full_speed: "仅在100%速度\n对您不可访问时调整", // "adjust only if the 100% speed\nmakes the game inaccessible for you"
text_vibrate: "震动：", // "vibration: "
text_buttons: "显示按钮：", // "show buttons: "

text_resume: "继续", // "resume"
text_changelevel: "更改关卡", // "change level"
text_giveup: "回到菜单", // "go to menu"

text_skip: "您可以在暂停菜单中跳过此关卡", 


	//			 .o88b. d8888b. d88888b d8888b. d888888b d888888b .d8888. 
	//			d8P  Y8 88  `8D 88'     88  `8D   `88'   `~~88~~' 88'  YP 
	//			8P      88oobY' 88ooooo 88   88    88       88    `8bo.   
	//			8b      88`8b   88~~~~~ 88   88    88       88      `Y8b. 
	//			Y8b  d8 88 `88. 88.     88  .8D   .88.      88    db   8D 
	//			 `Y88P' 88   YD Y88888P Y8888D' Y888888P    YP    `8888Y' 
     

	//	os créditos podem parecer confusos por não estarem na ordem que aparecessem no jogo
	
	titulo: [
    "游戏制作",
    "音乐和音效",
    "附加编程",
    "移植",
	"附加关卡设计（DLC）由",
],

nome: [
    "Gustavo Barros",
    "Dani Serranú",
    "Luiz Alves, Rowan Future and Daniel Neto",
    "James Begg",
	"Hugo Balthazar",
],

titulo_art: "封面艺术",
	
nomes_art: [
    "Aimee Cairns & João Alves \"Pyro\" (DLC)",
],

titulo_trans: "英文翻译",
	
nomes_trans: [
    "Gustavo Barros",
],

titulo_tester: "测试者",

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
		"DLC前的玩家",
	],

titulo_agradecimentos: "特别鸣谢",

    nomes_agradecimento: [
        "Sr Pelo", "NamaTakahashi",
        "Moony Team",
        "Dani Serranú",
        "Garope",
        "Vitória Nedel",
        "Thomas",
        "母亲、姐姐和朱莉（我的狗）",
        "Miguel Mendes",
        "Isabel Marinho和GameMaker团队",
    ],

    agradecimento: [
		"亲切地允许包括Skid和Pump",
		"借用您的角色，感谢！",
		"Estrelano的创作",
        "对游戏的支持和关怀",
        "设计前两个生物并提供支持",
        "给古斯的支持",
        "给达尼的支持和亲吻",
        "多年来的巨大支持",
        "诗歌翻译和各种繁文缛节",
        "令人难以置信的支持和各种机会",
    ],

    agradecimento_extra: [
		"(观看 Spooky Month)",
		"(玩 Elechead)",
		"(玩 Funky Moonleap)",
		"(由 Gus 撰写的文字)",
        "",
        "",
        "",
        "",
        "",
        "",
],
titulo_obrigado: "同时感谢",

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
    "家人和朋友",
    "我的叔叔鲍比",
    "你！",
],


// Do not translate "#NoticeMe Game Jam".

finais_titulo: [
    "艺术制作",
    "游戏创建",
    "诗歌作者",
],

// Do not translate "Bard Audio Engine".

finais_nome: [
    "Aseprite",
    "GameMaker",
    "Helen Steiner Rice",
],

// Do not translate "Aseprite" or "GameMaker". They are software names.

agradecimento_final: "感谢您的游玩！",

	//			d8888b.  .d88b.   .d88b.  .88b  d88.      d8b   db  .d8b.  .88b  d88. d88888b .d8888. 
	//			88  `8D .8P  Y8. .8P  Y8. 88'YbdP`88      888o  88 d8' `8b 88'YbdP`88 88'     88'  YP 
	//			88oobY' 88    88 88    88 88  88  88      88V8o 88 88ooo88 88  88  88 88ooooo `8bo.   
	//			88`8b   88    88 88    88 88  88  88      88 V8o88 88~~~88 88  88  88 88~~~~~   `Y8b. 
	//			88 `88. `8b  d8' `8b  d8' 88  88  88      88  V888 88   88 88  88  88 88.     db   8D 
	//			88   YD  `Y88P'   `Y88P'  YP  YP  YP      VP   V8P YP   YP YP  YP  YP Y88888P `8888Y' 

	//	A maior parte dos nomes dão dicas de como a fase deve ser solucionada
	//	caso tenham dúvidas chequem o jogo ou entrem em contato comigo
	
Room0: "1 - 越过月亮",		
Room1: "2 - 跳跃变化",		
Room2: "3 - 荒谬",			
Room3: "4 - 混凝草叶",		
Room4: "5 - 叶子离开",		
Room5: "6 - 传送门",		
Room6: "7 - 蜗牛下方",		
Room7: "8 - 无敌手",		
Room8: "9 - 蜗牛花园", 
Room9: "10 - 它活了",		
Room10: "11 - 云中头",		
Room11: "12 - 无头无尾",	
Room12: "13 - 空中动物群",
Room13: "14 - 来回往返",
Room14: "15 - 易碎",
Room15: "16 - 支撑点",		
Room16: "17 - 坏虫子",		
Room17: "18 - 见星星了",	
Room18: "19 - 美杜莎",		
Room19: "20 - 昆虫梯子",
Room20: "21 - 转身变化！",
Room21: "22 - 生命是多变的", 
Room22: "23 - 误会",
Room23: "24 - 方向",		
Room24: "25 - 跨越尖刺",
Room25: "26 - 回归常态",
Room26: "27 - 一次过",		
Room27: "28 - $惊吓$",
Room28: "29 - 给我给我",	
Room29: "30 - 大概不可能", 
Room30: "31 - 星尘",              
Room31: "32 - 横行天下",          
Room32: "33 - 启示？",            
Room33: "34 - 不可避免的时间",     
Room34: "35 - 影子之舞",          
Room35: "36 - 无控制",            
Room36: "37 - 无空间",            
Room37: "38 - 无时间",            
Room38: "39 - 蹦床",              
Room39: "40 - 跳跃变化？",        
Room40: "#1?# - 秘密地牢",        
Room41: "#2?# - 注意脚下",        
Room42: "#3?# - 活板门",            
Room43: "#4?# - 关卡命名不是我的强项",
Room44: "#5?# - 笼中蝙蝠",          
Room45: "#6?# - 魔法球",            
Room46: "#7?# - 推推乐",            
Room47: "#8?# - 搭便车",            
Room48: "#9?# - 小卫兵",            
Room49: "#10?# - 空中跳跃",         

// Secret levels
Room50: "#?# - 迷宫",               
Room51: "#?# - 蜗牛下",             
Room54: "#?# - 头锤",               
Room53: "#?# - 天花板上的花",       
Room52: "#?# - 魔法蘑菇",           
Room59: "#?# - 正确的一面",         
Room58: "#?# - 捉住乌鸦",           
Room57: "#?# - 弹弹乐",             
Room56: "#?# - 方向牢笼",           
Room55: "#?# - 祝你好运",           

// Final levels
Room60: "@终@ - 闪回",              
Room61: "@终@ - 永久懲役",		
Room62: "@终@ - 反转",              
Room63: "@终@ - 自取其乐",          

}
);

