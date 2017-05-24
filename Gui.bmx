


' Gui 
Global  Gui:TGui = TGui.Create(inputs)
gui.Alpha = 0.8


Global CheckBox_MusicPlayPause:TCheckBox = TCheckBox.Create("", 986, 5, 28, 28, Null, Img_BtnMusicPausePlay)
CheckBox_MusicPlayPause.State = 1
CheckBox_MusicPlayPause.TooltipText = "Musik Ein/Aus"

' Play / Pause
Global Panel_Time:TPanel = TPanel.Create(5, 5, 230, 75)
Global CheckBox_PlayPause:TCheckBox = TCheckBox.Create("", 3, 5, 28, 28, Panel_Time, Img_BtnPausePlay)
CheckBox_PlayPause.TooltipText = "Start/Stop"
Global TextBox_Date:TTextBox = TTextBox.Create("01.01.2000", 40, 10, 185, 20, True, Panel_Time)
Global Slider_TimeSpeed:TSlider = TSlider.Create(5, 40, 100, 25, 1, 9, 1.1, Panel_Time)
Slider_TimeSpeed.TooltipText = "Simulations-Geschwindigkeit"
Global TextBox_TimeSpeed:TTextBox = TTextBox.Create("", 110, 42, 115, 20, True, Panel_Time)



' Schnell Einstellungen
Global Panel_FastSettings:TPanel = TPanel.Create(8, 650, 80, 110)
Global Btn_ResetView:TButton = TButton.Create("" , 7, 5, 29, 29, Panel_FastSettings, Img_BtnResetView)
Btn_ResetView.TooltipText = "Ansicht zurücksetzen"
Global Btn_RemoveAllAsteroids:TButton = TButton.Create("" , 7, 40, 29, 29, Panel_FastSettings, Img_BtnRemoveAsteroids)
Btn_RemoveAllAsteroids.TooltipText = "Entferne alle Asteroiden"
Global Btn_ResetSolarSystem:TButton = TButton.Create("" , 7, 75, 29, 29, Panel_FastSettings, Img_BtnResetSolarSystem)
Btn_ResetSolarSystem.TooltipText = "Setze das Sonnensystem zurück"
Global Slider_RotateView:TSlider = TSlider.Create(45, 5, 25, 100, 0, 1, 0.5, Panel_FastSettings)
Slider_RotateView.ToolTipText = "Neige die Ansicht"



' Haupt Tabber
Global Tabber_Main:TTabber = TTabber.Create(100, 650, 900, 110)
' Tab Planet Info
Global Tab_PlanetInfo:TTab = Tabber_Main.AddTab("Planeten Info")
' Tab Asteroiden Erstellen
Global Tab_Asteroid:TTab = Tabber_Main.AddTab("Asteroiden")
' Checkbox Tabber Hoch/Runter
Global CheckBox_TabberUpDown:TCheckBox = TCheckBox.Create("", 998, 735, 18, 25, Null, Img_BtnTabberUpDown)
CheckBox_TabberUpDown.State = 1
CheckBox_TabberUpDown.TooltipText = "Tabber Ein/Aus"



' PlanetInfo Tab
Global TextBox_PlanetName:TTextBox = TTextBox.Create("Name: ", 10, 5, 180, 20, False, Tab_PlanetInfo)
Global TextBox_PlanetMass:TTextBox = TTextBox.Create("Masse: ", 10, 30, 180, 20, False, Tab_PlanetInfo)
Global TextBox_PlanetDensity:TTextBox = TTextBox.Create("Dichte: ", 10, 55, 180, 20, False, Tab_PlanetInfo)

Global TextBox_PlanetDistanceToSun:TTextBox = TTextBox.Create("Durchschnittsentfernung der Umlaufbahn zum Sonnenmittelpunkt: ", 10, 80, 300, 20, False, Tab_PlanetInfo)


Global TextBox_PlanetDiameter:TTextBox = TTextBox.Create("Durchmesser: ", 200, 5, 210, 20, False, Tab_PlanetInfo)
Global TextBox_PlanetAroundSun:TTextBox = TTextBox.Create("Umlaufzeit um Sonne: ", 200, 30, 210, 20, False, Tab_PlanetInfo)
Global TextBox_PlanetAroundSelf:TTextBox = TTextBox.Create("Rotationszeit um eigene Achse: ", 200, 55, 210, 20, False, Tab_PlanetInfo)




' Asteroid Tab
Global TextBox_CreateAstroid:TTextBox = TTextBox.Create("Asteroid erstellen: ", 10, 5, 300, 100, False, Tab_Asteroid)
Global Slider_AsteroidMass:TSlider = TSlider.Create(12, 30, 100, 25, 0, 11, 1.1, Tab_Asteroid)
Slider_AsteroidMass.ToolTipText = "Lege die Masse des Asteroiden fest"
Global TextBox_AstroidMass:TTextBox = TTextBox.Create("Masse: 0.5 x Sonnenmasse", 120, 32, 180, 20, False, Tab_Asteroid)
Global Btn_CreateAsteroid:TButton = TButton.Create("Startposition setzen", 30, 70, 140, 20, Tab_Asteroid)
Btn_CreateAsteroid.ToolTipText = "Lege die Startposition des Asteroiden fest"
Global Btn_CreateAsteroidAbort:TButton = TButton.Create("Abbrechen", 185, 70, 100, 20, Tab_Asteroid)
Btn_CreateAsteroidAbort.ToolTipText = "Brich das Erstellen eines Asteroiden ab"





Function UpdateGuiLogic(visualizer:TVisualizer, time:TSolarTime, solarPlanetParameter:TSolarPlanetParameter, musicHandler:TMusicHandler)
	TextBoxDateLogic(time)
	TabberUpDownLogic()
	ResetMainViewLogic(visualizer)
	UpdateRotateViewLogic(visualizer)
	TimeSpeedLogic(time)
	UpdatePlanetInfo()
	UpdateSliderAsteroidMassLogic()
	UpdateBtnAsteroidLogic(solarPlanetParameter)
	UpdateBtnRemoveAsteroidsLogic()
	UpdateBtnResetSolarSystemLogic(visualizer, solarPlanetParameter, time)
	UpdateMusicPausePlayLogic(musicHandler)
End Function


Function TabberUpDownLogic()
	If CheckBox_TabberUpDown.State = 1
		Tabber_Main.Y = 650
	ElseIf CheckBox_TabberUpDown.State = 0
		Tabber_Main.Y = 770
	End If
End Function


Function ResetMainViewLogic(visualizer:TVisualizer)
	If Btn_ResetView.IsPressed()
		visualizer.ResetView()
	End If
End Function


Function UpdateRotateViewLogic(visualizer:TVisualizer)
	visualizer.XRotation = Slider_RotateView.Value
End Function


Function TextBoxDateLogic(time:TSolarTime)
	TextBox_Date.Text = time.Date.Date()
End Function


Function TimeSpeedLogic(time:TSolarTime)
	Select Int(Slider_TimeSpeed.Value)
		'Case 0 time.TimeFactor = 0
		Case 1 time.TimeFactor = 0.033
		Case 2 time.TimeFactor = 0.1
		Case 3 time.TimeFactor = 0.5
		Case 4 time.TimeFactor = 1
		Case 5 time.TimeFactor = 2
		Case 6 time.TimeFactor = 5
		Case 7 time.TimeFactor = 10
		Case 8 time.TimeFactor = 20
		Case 9 time.TimeFactor = 50

	End Select
	If CheckBox_PlayPause.State = 0
		time.TimeFactor = 0
	End If
	
	If time.TimeFactor = 0
		TextBox_TimeSpeed.Text = "Zeit angehalten"
	Else
		TextBox_TimeSpeed.Text = (time.DaysPerSecond ) + " Tage/sek"
	End If
End Function




Function UpdatePlanetInfo()
	' Name
	If TPlanet.SelectedPlanet <> Null
		TextBox_PlanetName.Text = "Name: " + TPlanet.SelectedPlanet.Name
	Else
		TextBox_PlanetName.Text = "Name: "
	End If
	
	' Masse
	If TPlanet.SelectedPlanet <> Null
		TextBox_PlanetMass.Text = TPlanet.SelectedPlanet.Description.Mass
	Else
		TextBox_PlanetMass.Text = "Masse: "
	End If
	
	' Dichte
	If TPlanet.SelectedPlanet <> Null
		TextBox_PlanetDensity.Text = TPlanet.SelectedPlanet.Description.Density
	Else
		TextBox_PlanetDensity.Text = "Dichte: "
	End If
	
	' Entfernung zur Sonne
	If TPlanet.SelectedPlanet <> Null
		TextBox_PlanetDistanceToSun.Text = TPlanet.SelectedPlanet.Description.DistanceToSun
	Else
		TextBox_PlanetDistanceToSun.Text = "Entfernung zur Sonne: "
	End If
	
	' Durchmesser
	If TPlanet.SelectedPlanet <> Null
		TextBox_PlanetDiameter.Text = TPlanet.SelectedPlanet.Description.Diameter
	Else
		TextBox_PlanetDiameter.Text = "Durchmesser: "
	End If
	
	' Umlaufzeit um die Sonne
	If TPlanet.SelectedPlanet <> Null
		TextBox_PlanetAroundSun.Text = TPlanet.SelectedPlanet.Description.AroundSun
	Else
		TextBox_PlanetAroundSun.Text = "Umlaufzeit um Sonne: "
	End If
	
	' Rotationszeit um die eignene Achse
	If TPlanet.SelectedPlanet <> Null
		TextBox_PlanetAroundSelf.Text = TPlanet.SelectedPlanet.Description.AroundSelf
	Else
		TextBox_PlanetAroundSelf.Text = "Achsrotation: "
	End If
End Function



' Asteroiden erstellen 

Function UpdateSliderAsteroidMassLogic()
	Select Int(Slider_AsteroidMass.Value)
		Case 0
			TextBox_AstroidMass.Text = "Masse: 0.5 x Mondmasse"
		Case 1
			TextBox_AstroidMass.Text = "Masse: 1 x Mondmasse"
		Case 2
			TextBox_AstroidMass.Text = "Masse: 2 x Mondmasse"
		Case 3
			TextBox_AstroidMass.Text = "Masse: 0.5 x Erdmasse"
		Case 4
			TextBox_AstroidMass.Text = "Masse: 1 x Erdmasse"
		Case 5
			TextBox_AstroidMass.Text = "Masse: 2 x Erdmasse"
		Case 6
			TextBox_AstroidMass.Text = "Masse: 0.5 x Jupitermasse"
		Case 7
			TextBox_AstroidMass.Text = "Masse: 1 x Jupitermasse"
		Case 8
			TextBox_AstroidMass.Text = "Masse: 2 x Jupitermasse"
		Case 9
			TextBox_AstroidMass.Text = "Masse: 0.5 x Sonnenmasse"
		Case 10
			TextBox_AstroidMass.Text = "Masse: 1 x Sonnenmasse"
		Case 11
			TextBox_AstroidMass.Text = "Masse: 2 x Sonnenmasse"
	End Select
End Function

Function UpdateBtnAsteroidLogic(solarPlanetParameter:TSolarPlanetParameter)
	If Btn_CreateAsteroid.IsPressed()
		Local asteroidMass:Double
		
		Select Int(Slider_AsteroidMass.Value)
			Case 0
				asteroidMass = solarPlanetParameter.MoonNormalMass / 2
			Case 1
				asteroidMass = solarPlanetParameter.MoonNormalMass
			Case 2
				asteroidMass = solarPlanetParameter.MoonNormalMass * 2
			Case 3
				asteroidMass = solarPlanetParameter.EarthNormalMass / 2
			Case 4
				asteroidMass = solarPlanetParameter.EarthNormalMass
			Case 5
				asteroidMass = solarPlanetParameter.EarthNormalMass * 2
			Case 6
				asteroidMass = solarPlanetParameter.JupiterNormalMass / 2
			Case 7
				asteroidMass = solarPlanetParameter.JupiterNormalMass
			Case 8
				asteroidMass = solarPlanetParameter.JupiterNormalMass * 2
			Case 9
				asteroidMass = solarPlanetParameter.SunNormalMass / 2
			Case 10
				asteroidMass = solarPlanetParameter.SunNormalMass
			Case 11
				asteroidMass = solarPlanetParameter.SunNormalMass * 2
			Default
				asteroidMass = solarPlanetParameter.MoonNormalMass
		End Select
		TAsteroidEmitter.Create(asteroidMass)
	End If
	
	If Btn_CreateAsteroidAbort.IsPressed()
		TAsteroidEmitter.List.Clear()
	End If
End Function


Function UpdateBtnRemoveAsteroidsLogic()
	If Btn_RemoveAllAsteroids.IsPressed()
		RemoveAllAsteroids()
	End If
End Function

Function UpdateBtnResetSolarSystemLogic(visualizer:TVisualizer, solarParameter:TSolarPlanetParameter, solarTime:TSolarTime)
	If Btn_ResetSolarSystem.IsPressed()
		ResetSolarSystem(visualizer, solarParameter, solarTime)
		CheckBox_PlayPause.State = 0
		visualizer.ResetView()
	End If
End Function



Function UpdateMusicPausePlayLogic(musicHandler:TMusicHandler)
	If CheckBox_MusicPlayPause.State = 1
		musicHandler.Channel.SetVolume(1)
		musicHandler.Update()
	Else
		musicHandler.Channel.SetVolume(0)
	End If
End Function

Rem
Local btn1:TButton = TButton.Create("Tab1" , 12, 2, 40, 16, tab1)
Local textB:TTextBox = TTextBox.Create("Das ist eine TextBox in einem Tabber! :-)", 20, 20, 160, 80, False, tab4)
End Rem


































































