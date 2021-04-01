extends Node

var score_file = "user://highscore.save"
var enable_sound = true
var enable_music = true

var circles_per_level = 5

var color_schemes = {
	"NEON1": {
		'background': Color8(0, 0, 0),
		'player_body': Color8(203, 255, 0),
		'player_trail': Color8(204, 0, 255),
		'circle_fill': Color8(255, 0, 110), 
		'circle_static': Color8(0, 255, 102),
		'circle_limited': Color8(204, 0, 255)
	},
	"NEON2": {
		'background': Color8(0, 0, 0),
		'player_body': Color8(246, 255, 0),
		'player_trail': Color8(255, 255, 255),
		'circle_fill': Color8(255, 0, 110),
		'circle_static': Color8(151, 255, 48),
		'circle_limited': Color8(127, 0, 255)
	},
	"NEON3": {
		'background': Color8(0, 0, 0),
		'player_body': Color8(255, 0, 187),
		'player_trail': Color8(255, 148, 0),
		'circle_fill': Color8(255, 148, 0),
		'circle_static': Color8(170, 255, 0),
		'circle_limited': Color8(204, 0, 255)
	}
}

var theme = color_schemes["NEON1"]

static func rand_weighted(weights):
	var sum = 0
	for weight in weights:
		sum += weight
	var num = rand_range(0, sum)
	for i in weights.size():
		if num < weights[i]:
			return i
		num -= weights[i]
		
var admob = null
var real_ads = false
var banner_top = false
var ad_banner_id = ""
var ad_interstitial_id = ""
var enable_ads = true setget set_enable_ads
	
func _ready():
	if Engine.has_singleton("AdMob"):
		admob = Engine.get_singleton("AdMob")
		admob.init(real_ads, get_instance_id())
		admob.loadBanner(ad_banner_id, banner_top)
		admob.loadInterstitial(ad_interstitial_id)
		
func show_ad_banner():
	if admob and enable_ads:
		admob.showBanner()
		
func hide_ad_banner():
	if admob:
		admob.hideBanner()
		
func show_ad_interstitial():
	if admob and enable_ads:
		admob.showInterstitial()
		
func _on_interstitial_close():
	if admob and enable_ads:
		show_ad_banner()
		
func set_enable_ads(value):
	enable_ads = value
	if enable_ads:
		show_ad_banner()
	if !enable_ads:
		hide_ad_banner()
		
	
	
		
	
	
		
		
		
	
	
	
	
		
		
		
	
	