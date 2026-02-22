extends Node

@export var CatAnim:AnimationPlayer
@export var CamAnim:AnimationPlayer
@export var WoolAnim:AnimationPlayer

var IntroAnims = ["CamGameIntro" , "Game Intro" , "WoolGameIntro"]
var WinAnims = ["CamMinigameWin" , "MinigameWin", "WoolMinigameWin"]
var LoseAnims = ["CamMinigameLost" , "MinigameLost", "WoolMinigameLost"]
var SpeedUpAnims = ["CamSpeedUp" , "SpeedUp", "WoolSpeedUp"]
var StartAnim = ["CamMinigameStart" , "MinigameStart", "WoolMinigameStart"]
var BossAnim = ["CamBossMinigame" , "BossMinigame", "WoolBossMinigame"]
var EndingAnim = ["CamGameEnd" , "Game End","WoolGameEnd"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.cat_comence.connect(playIntro)
	GameManager.cat_win.connect(playMinigameWin)
	GameManager.cat_loose.connect(playMinigameLost)
	GameManager.cat_speedup.connect(playSpeedUp)
	GameManager.cat_intro.connect(playMinigameStart)
	GameManager.cat_boss.connect(playBossMinigame)
	GameManager.cat_victory.connect(playGameEnding)
	GameManager.UIocult.connect(_on_ui_ocult)
	GameManager.minigame_end.connect(_on_minigame_end)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func playIntro() -> void:
	CamAnim.play(IntroAnims[0])
	CatAnim.play(IntroAnims[1])
	WoolAnim.play(IntroAnims[2])
func playMinigameStart() ->void:
	CamAnim.play(StartAnim[0])
	CatAnim.play(StartAnim[1])
	WoolAnim.play(StartAnim[2])
	
func playMinigameWin() ->void:
	CamAnim.play(WinAnims[0])
	CatAnim.play(WinAnims[1])
	WoolAnim.play(WinAnims[2])
func playMinigameLost() ->void:
	CamAnim.play(LoseAnims[0])
	CatAnim.play(LoseAnims[1])
	WoolAnim.play(LoseAnims[2])
func playBossMinigame() ->void:
	CamAnim.play(BossAnim[0])
	CatAnim.play(BossAnim[1])
	WoolAnim.play(BossAnim[2])
	
func playGameEnding() ->void:
	CamAnim.play(EndingAnim[0])
	CatAnim.play(EndingAnim[1])
	WoolAnim.play(EndingAnim[2])
func playSpeedUp() -> void:
	CamAnim.play(SpeedUpAnims[0])
	CatAnim.play(SpeedUpAnims[1])
	WoolAnim.play(SpeedUpAnims[2])
func _on_ui_ocult():
	pass

func _on_minigame_end():
	pass
