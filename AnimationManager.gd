extends Node

@export var SceneAnimator:AnimationPlayer

var IntroAnims = ["CamGameIntro" , "Game Intro" , "WoolGameIntro"]
var WinAnims = ["CameMinigameWin" , "MinigameWin", "WoolMinigameWin"]
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
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func playIntro() -> void:
	for anim in 2:
		SceneAnimator.play(IntroAnims[anim])
	
func playMinigameStart() ->void:

	for anim in 2:
		SceneAnimator.play(StartAnim[anim])
	
func playMinigameWin() ->void:
	for anim in 2:
		SceneAnimator.play(WinAnims[anim])
	
func playMinigameLost() ->void:
	for anim in 2:
		SceneAnimator.play(LoseAnims[anim])
	
func playBossMinigame() ->void:
	for anim in 2:
		SceneAnimator.play(BossAnim[anim])
	
func playGameEnding() ->void:
	for anim in 2:
		SceneAnimator.play(EndingAnim[anim])
	
func playSpeedUp() -> void:
	for anim in 2:
		SceneAnimator.play(SpeedUpAnims[anim])
