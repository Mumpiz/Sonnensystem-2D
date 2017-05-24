
Rem
Incbin ""
Global Img_:TImage = LoadImage("Incbin::.png")
End Rem


' Font
Incbin "media\BerlinSmallCaps.ttf"
Global Font:TImageFont = LoadImageFont("Incbin::media\BerlinSmallCaps.ttf", 14)
SetImageFont Font


' Titelbild
Incbin "media\UnserSonnensystem2D.jpg"
Global Img_Title:TImage = LoadImage("Incbin::media\UnserSonnensystem2D.jpg")

' Hintergrund
Incbin "media\bg.png"
Global Img_BG:TImage = LoadImage("Incbin::media\bg.png")

Incbin "media\background.jpg"
Global Img_BackGround:TImage = LoadImage("Incbin::media\background.jpg")

Incbin "media\galaxis.png"
Global Img_Galaxis:TImage = LoadImage("Incbin::media\galaxis.png")



' Planeten
Incbin "media\sun.png"
Global Img_Sun:TImage = LoadImage("Incbin::media\sun.png")

Incbin "media\mercury.png"
Global Img_Mercury:TImage = LoadImage("Incbin::media\mercury.png")

Incbin "media\venus.png"
Global Img_Venus:TImage = LoadImage("Incbin::media\venus.png")

Incbin "media\earth.png"
Global Img_Earth:TImage = LoadImage("Incbin::media\earth.png")

Incbin "media\mars.png"
Global Img_Mars:TImage = LoadImage("Incbin::media\mars.png")

Incbin "media\jupiter.png"
Global Img_Jupiter:TImage = LoadImage("Incbin::media\jupiter.png")

Incbin "media\saturn.png"
Global Img_Saturn:TImage = LoadImage("Incbin::media\saturn.png")

Incbin "media\uranus.png"
Global Img_Uranus:TImage = LoadImage("Incbin::media\uranus.png")

Incbin "media\neptun.png"
Global Img_Neptun:TImage = LoadImage("Incbin::media\neptun.png")

Incbin "media\pluto.png"
Global Img_Pluto:TImage = LoadImage("Incbin::media\pluto.png")

Incbin "media\deadPlanet.png"
Global Img_DeadPlanet:TImage = LoadImage("Incbin::media\deadPlanet.png")

Incbin "media\asteroid.png"
Global Img_Asteroid:TImage = LoadImage("Incbin::media\asteroid.png")



' Gui

Incbin "media\Btn_ResetView.png"
Global Img_BtnResetView:TImage = LoadImage("Incbin::media\Btn_ResetView.png")

Incbin "media\Btn_RemoveAsteroids.png"
Global Img_BtnRemoveAsteroids:TImage = LoadImage("Incbin::media\Btn_RemoveAsteroids.png")

Incbin "media\Btn_ResetSolarSystem.png"
Global Img_BtnResetSolarSystem:TImage = LoadImage("Incbin::media\Btn_ResetSolarSystem.png")





Incbin "media\Btn_Pause_Play.png"
Global Img_BtnPausePlay:TImage = LoadAnimImage("Incbin::media\Btn_Pause_Play.png", 16, 16, 0, 2)

Incbin "media\Btn_Music_Pause_Play.png"
Global Img_BtnMusicPausePlay:TImage = LoadAnimImage("Incbin::media\Btn_Music_Pause_Play.png", 16, 16, 0, 2)

Incbin "media\Btn_TabberUpDown.png"
Global Img_BtnTabberUpDown:TImage = LoadAnimImage("Incbin::media\Btn_TabberUpDown.png", 12, 20, 0, 2)



' Music
Incbin "media\Breath.ogg"
Global BGMusic:TSound = LoadSound("Incbin::media\Breath.ogg")
Global BGChannel:TChannel = AllocChannel()














