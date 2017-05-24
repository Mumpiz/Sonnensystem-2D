SuperStrict


Framework BRL.GLMax2D
Import BRL.Random
Import BRL.Timer
Import BRL.Retro
Import BRL.FreeAudioAudio
Import BRL.FreeTypeFont
Import BRL.JPGLoader
Import BRL.PNGLoader
Import BRL.OGGLoader

SetGraphicsDriver GLMax2DDriver()
SetAudioDriver("FreeAudio DirectSound")

AppTitle = "Unser Sonnensystem 2D  1.0    by Michael Frank"

SeedRnd(MilliSecs())

Include "TRgb.bmx"
Include "TVisualizer.bmx"
Include "TPlanet.bmx"
Include "TTracer.bmx"
Include "TGauss.bmx"
Include "TSolarTime.bmx"
Include "TSolarPlanetParameter.bmx"
Include "TAsteroidEmitter.bmx"
Include "TGui\TInputHandler\TInputHandler.bmx"
Include "Input.bmx"
Include "TGui\TGui.bmx"
Include "TMusicHandler.bmx"


Local visualizer:TVisualizer = TVisualizer.Create(1024, 768)
Graphics visualizer.GraphicW, visualizer.GraphicH
SetBlend( ALPHABLEND )

Include "Media.bmx"


DrawTitle()


Local inputs:TInput = New TInput

' Muss nach dem Grapics-Befehl inkludiert werden!
Include "Gui.bmx"


Local music:TMusicHandler = TMusicHandler.Create(BGMusic, BGChannel)


Local color:TRgb = TRgb.Random()
Local gauss:TGauss = New TGauss
Local solarTime:TSolarTime = New TSolarTime

Local solarParameter:TSolarPlanetParameter = New TSolarPlanetParameter 

InitSolarSystem(visualizer)
TPlanet.NormalizeWithSun(solarParameter.SunRealMass, solarParameter.SunNormalMass)

Local timer:TTimer = CreateTimer( 60 )

Repeat


	solarTime.UpdateSolarSystem(gauss:TGauss)
	visualizer.Update(inputs)
	TPlanet.RenderAll(visualizer)
	inputs.Update()
	UpdatePlanetSelection(inputs, visualizer)


	TAsteroidEmitter.UpdateAsteroidEmitter(gui, inputs, visualizer, gauss, solarTime)
	
	' Gui
	gui.Update()
	gui.Draw()
	UpdateGuiLogic(visualizer, solarTime, solarParameter, music)
	
	DrawText Int(TPlanet(TPlanet.List.First()).VX), 0, 300

Flip();Cls;WaitTimer( timer )

	' Media
	
	TileImage( Img_BackGround, visualizer.OffsetX/10 - visualizer.GraphicW/2, visualizer.OffsetY/10 - visualizer.GraphicH/2)
	SetScale( 1 + visualizer.Zoom/100000, 1 + visualizer.Zoom/100000)
	DrawImage( Img_Galaxis, visualizer.OffsetX/10, visualizer.OffsetY/10)
	SetScale( 1, 1 )
	TileImage( Img_Bg, visualizer.OffsetX, visualizer.OffsetY )


Until AppTerminate() Or KeyHit(KEY_ESCAPE)





Function DrawTitle()
	Cls
	DrawImage Img_Title, 0, 0
	Flip()
	WaitKey()
End Function








Function ManageBGMusic()
	
End Function

