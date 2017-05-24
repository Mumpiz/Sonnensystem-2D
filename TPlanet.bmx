

Type TPlanet

	Global List:TList = New TList
	Field Link:TLink
	
	Global SelectedPlanet:TPlanet
	
	Field Image:TImage
	Field Selected:Byte = False
	Field CenterViewToMe:Byte = False
	
	Field Name:String
	
	Field Description:TPlanetDescription
	
	Field X:Double
	Field Y:Double
	Field Z:Double
	Field VX:Double
	Field VY:Double
	Field VZ:Double
	Field Mass:Double
	
	Field ScreenX:Float
	Field ScreenY:Float
	
	Field Radius:Float
	
	Field DrawSize:Float
	' Der Schweif hinter einem Planeten
	Field Tracer:TTracer
	Field Color:TRgb

	Function Create:TPlanet(name:String, x:Double, y:Double, z:Double, vx:Double, vy:Double, vz:Double, mass:Double, image:TImage, color:TRgb = Null, description:TPlanetDescription = Null)
		Local planet:TPlanet = New TPlanet
		planet.Name = name
		planet.X = x 
		planet.Y = y
		planet.Z = z
		planet.VX = vx
		planet.VY = vy
		planet.VZ = vz
		planet.Mass = mass
		planet.Image = image
		If image <> Null Then SetImageHandle( image, ImageWidth(image)/2, ImageHeight(image)/2 )
		planet.Color = color
		If description <> Null Then  planet.Description = description
		planet.Tracer = TTracer.Create(100)
		Return planet
	End Function
	
	
	Method DrawTracerUsingVisualizer(visualizer:TVisualizer)
		If Self.Tracer <> Null
			SetColor Self.Color.R, Self.Color.G, Self.Color.B
			Self.Tracer.DrawUsingVisualizer(visualizer)
			SetColor 255, 255, 255
		End If
	End Method
	
	
	Method SizeFromVisualizer:Float(visualizer:TVisualizer)
		Local size:Float
		' Visuelle größe berechnen
		size = Sqr( Self.Mass / Pi ) * visualizer.Zoom
		Rem
		If Self.Mass >= 1
			size = 1  * visualizer.Zoom
		Else
			
		End If
		End Rem
		'If Self.Name = "Sonne" Or Self.Name = "Sun" Then size = 80
		'size = size * 6
		If size < 1 size = 1
		Return size
	End Method
	
	
	Method DrawUsingVisualizer(visualizer:TVisualizer)
		Local size:Float = SizeFromVisualizer(visualizer)

		If Self.Selected And Self.CenterViewToMe Then visualizer.CenterToPlanet(Self)

		Self.ScreenX =  ( Self.X  * visualizer.Zoom ) + visualizer.GraphicW/2 + visualizer.OffsetX
   		Self.ScreenY =  Self.Y  * visualizer.Zoom * visualizer.XRotation + visualizer.GraphicH/2 + visualizer.OffsetY

		'Self.ScreenX = ( Self.X * visualizer.Zoom ) + visualizer.GraphicW/2 + visualizer.OffsetX
   		'Self.ScreenY = ( Self.Y * visualizer.Zoom ) + visualizer.GraphicH/2 + visualizer.OffsetY

		
		' Schweif (Tracer) des Planeten zeichnen
		
		DrawTracerUsingVisualizer(visualizer)
		
		' Planet Zeichnen
		If Self.Image <> Null
			SetScale( size/1000, size/1000 )
			DrawImage( Self.Image, Self.ScreenX, Self.ScreenY)
			SetScale ( 1, 1 )
		Else
			SetColor Self.Color.R, Self.Color.G, Self.Color.B
			DrawOval(Self.ScreenX - size/2, Self.ScreenY  - size/2 , size, size)
			SetColor 255, 255, 255
		End If
		
			
		If Self.Selected
			DrawBorder(Self.ScreenX - size/8 - visualizer.Zoom/8, Self.ScreenY  - size/8 - visualizer.Zoom/8, size/4 + visualizer.Zoom/4, size/4 + visualizer.Zoom/4)
			SetColor 255,120,0
			DrawText Self.Name, Self.ScreenX + 10, Self.ScreenY - 20
			SetColor 255, 255, 255
		Else
			If Self.Name = "Asteroid"
				SetColor 120, 120, 120
				DrawText Self.Name, Self.ScreenX + 10, Self.ScreenY - 20
			Else
				SetColor 255, 255, 180
				DrawText Self.Name, Self.ScreenX + 10, Self.ScreenY - 20
			End If
		End If
		SetColor 255, 255, 255
	End Method


	Method UpdateSelection(visualizer:TVisualizer)
		Local distance:Float = GetDistance( Self.ScreenX, Self.ScreenY, MouseX(), MouseY())
		If distance < 25
			If Self.Selected = True
				Self.CenterViewToMe = True
				DeselectAll(Self)
			Else
				Self.Selected = True
				Self.CenterViewToMe = False
				If Self.Name <> "Asteroid" Then SelectedPlanet = Self
				DeselectAll(Self)
			End If
		Else
			Self.Selected = False
		End If
	End Method


	Method New()
		Self.Link = List.AddLast( Self )
	End Method
	
	Method Free()
	      If Self.Link
	        	Self.Link.Remove()
	         	Self.Link = Null
	      EndIf
	EndMethod
	
	
	
	Function UpdateAll(gauss:TGauss, time:TSolarTime)
		' Beschleunigungs-Variablen
		Local ax:Double
		Local ay:Double
		Local az:Double
		
		' Wegvector zwischen 2 Planeten
		Local xP2P1:Double
		Local yP2P1:Double
		Local zP2P1:Double
		
		' Der Abstand zwischen 2 Planeten
		Local distance:Double
		
		' Der Abstand zwischen 2 Planeten hoch3
		Local distance3:Double
		
		Local distance_2D:Double
		Local distance3_2D:Double
		
		Local coeff:Double
		
		For Local planet1:TPlanet = EachIn TPlanet.List
			' Beschleunigung zur Neuberechnung zurücksetzen
			ax = 0
			ay = 0
			az = 0
			For Local planet2:TPLanet = EachIn TPlanet.List
				' Ein Planet kann sich nicht selber anziehen
				If planet2 = planet1 Then Continue
				
				' Der Wegvector zwischen Planet2 und Planet1 wird berechnet
				xP2P1 = planet2.X - planet1.X
				yP2P1 = planet2.Y - planet1.Y
				zP2P1 = planet2.Z - planet1.Z
				
				' Die Distanz zwischen 2 Planeten wird berechnet
				distance = Sqr(zP2P1 * zP2P1 + yP2P1 * yP2P1 + xP2P1 * xP2P1)
				
				'Die Distanz wird hoch3 genommen
				distance3 = distance * distance * distance
				
				
				distance_2D = Sqr(yP2P1 * yP2P1 + xP2P1 * xP2P1)
				distance3_2D = distance_2D * distance_2D * distance_2D
				
				If distance3_2D <= planet1.Mass/480 + planet2.Mass/480
					If planet1.Mass >= planet2.Mass
						Fusion(planet1, planet2)
					Else
						Fusion(planet2, planet1)
					End If
				End If
				

				'Betrag der Gravitationsbeschleunigung nach Gauß und korrektur für die fehlende Normalisierung
				coeff = gauss.K2 * planet2.Mass / (distance3 / SSF)
				ax = coeff * xP2P1 + ax
				ay = coeff * yP2P1 + ay
				az = coeff * zP2P1 + az
			Next
			
			'neue Geschwindigkeit berechnen ( 101.5 ist der Korrekturwert, damit die Erde genau bei 365,24 Tagen die Sonne einmal umkreist )
			planet1.VX = planet1.VX + ax * ( (time.TimeStep/100)*101.5)
			planet1.VY = planet1.VY + ay * ( (time.TimeStep/100)*101.5)
			planet1.VZ = planet1.VZ + az * ( (time.TimeStep/100)*101.5)
			
			
			' Neue Position berechnen
			planet1.X = planet1.X + planet1.VX * ( (time.TimeStep/100)*101.5)
			planet1.Y = planet1.Y + planet1.VY * ( (time.TimeStep/100)*101.5)
			planet1.Z = planet1.Z + planet1.VZ * ( (time.TimeStep/100)*101.5 )
			
			' Neuen Tracerpunkt erstellen
			If planet1.Tracer <> Null
				planet1.Tracer.CreateDot(planet1.X, planet1.Y)
			End If
		Next
	End Function
	
	
	Function RenderAll(visualizer:TVisualizer)
		For Local planet:TPlanet = EachIn TPlanet.List
			
			planet.DrawUsingVisualizer(visualizer)
		Next
	End Function
	
	
	Function Fusion(planet1:TPlanet, planet2:TPlanet)
		planet1.VX = ( planet1.VX * planet1.Mass + planet2.VX * planet2.Mass ) / ( planet1.Mass + planet2.Mass )
		planet1.VY = ( planet1.VY * planet1.Mass + planet2.VY * planet2.Mass ) / ( planet1.Mass + planet2.Mass )
	
		planet1.X = planet1.X + ( planet2.X - planet1.X ) * planet2.Mass / ( planet1.Mass + planet2.Mass )
		planet1.Y = planet1.Y + ( planet2.Y - planet1.Y ) * planet2.Mass / ( planet1.Mass + planet2.Mass )
	
		If planet2.Mass > planet1.Mass/2 And planet1.Name <> "Asteroid"
			planet1.Image = Img_DeadPlanet
			SetImageHandle( planet1.Image, ImageWidth(planet1.Image)/2, ImageHeight(planet1.Image)/2 )
			planet1.Mass = planet1.Mass/2 + planet2.Mass/2
			If Not Instr(planet1.Name, "(Tot)")
				planet1.Name = planet1.Name + " (Tot)"
			End if
		Else
			planet1.Mass = planet1.Mass + planet2.Mass/3
		End If
		
		planet2.Free()
	End Function
	
	
	Function NormalizeWithSun(sunRealMass:Double, sunNormalMass:Double)
		For Local planet:TPlanet = EachIn TPlanet.List
			If planet.Name = "Sonne" Or planet.Name = "Sun" Then Continue
			planet.Mass = planet.Mass / sunRealMass
		Next
		For Local planet:TPlanet = EachIn TPlanet.List
			If planet.Name = "Sonne" Or planet.Name = "Sun"
				planet.Mass = sunNormalMass
				Exit
			End If
		Next
	End Function
	
	Function DeselectAll(exceptPlanet:TPlanet = Null)
		If exceptPlanet <> Null
			For Local planet:TPlanet = EachIn TPlanet.List
				If planet <> exceptPlanet
					planet.Selected = False
					planet.CenterViewToMe = False
				End If
			Next
		Else
			For Local planet:TPlanet = EachIn TPlanet.List
				planet.Selected = False
				planet.CenterViewToMe = False
			Next
		End If
	End Function
	

End Type








Type TPlanetDescription
	Field Mass:String
	Field Density:String
	Field DistanceToSun:String
	Field Diameter:String
	Field AroundSun:String
	Field AroundSelf:String
End Type



































Function InitSolarSystem(visualizer:TVisualizer)
	' Daten der Planeten Stand 01.01.2000
	
	Rem
	description = New TPlanetDescription
	description.Mass = "Masse:  · kg"
	description.Density = "Dichte: "
	description.DistanceToSun = "Entfernung zur Sonne: km"
	description.Diameter = "Durchmesser: km"
	description.AroundSun = "Umlaufzeit um Sonne: "
	description.AroundSelf = "Achsrotation: "
	End Rem
	
	Local color:TRgb
	Local description:TPlanetDescription
	
	
	
	
	' Sonne
	color = TRGB.Create(255, 255, 0)
	description = New TPlanetDescription
	description.Mass = "Masse: 1,991 · 10 ^ 30 kg"
	description.Density = "Dichte: 1,408 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: /"
	description.Diameter = "Durchmesser: 1 392 700 km"
	description.AroundSun = "Umlaufzeit um Sonne: /"
	description.AroundSelf = "Achsrotation: 25 Tage"
	TPlanet.Create("Sonne",  0.0000000 ,   0.0000000 ,   0.0000000 ,  0.000000000 ,  0.000000000 ,  0.000000000 , 1.991*10^30, Img_Sun, color, description)
	
	
	' Merkur
	color = TRGB.Create(255 ,  64 ,   0)
	description = New TPlanetDescription
	description.Mass = "Masse: 3,302 · 10 ^ 23 kg"
	description.Density = "Dichte: 5,427 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: 57 900 000 km"
	description.Diameter = "Durchmesser: 4 840 km"
	description.AroundSun = "Umlaufzeit um Sonne: 88 Tage"
	description.AroundSelf = "Achsrotation: 59 Tage"
	TPlanet.Create("Merkur"  ,  -0.1778023*SSF ,  -0.3863251*SSF,  -0.1879025*SSF,  0.020335410 , -0.007559570 , -0.006147710 , 3.191*10^23, Img_Mercury, color, description)
	
	' Venus
	color = TRGB.Create(255 , 192 , 128)
	description = New TPlanetDescription
	description.Mass = "Masse: 4,886 · 10 ^ 24"
	description.Density = "Dichte: 5,243 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: 108 000 000 km"
	description.Diameter = "Durchmesser: 12 200 km"
	description.AroundSun = "Umlaufzeit um Sonne: 225 Tage"
	description.AroundSelf = "Achsrotation: 243 Tage"
	TPlanet.Create("Venus"   ,    0.1787301*SSF,  -0.6390267*SSF,  -0.2987722*SSF,  0.019469170 ,  0.004915870 ,  0.000978980 , 4.886*10^24, Img_Venus, color, description)
	
	
	' Erde
	color = TRGB.Create( 0 ,   0 , 255)
	description = New TPlanetDescription
	description.Mass = "Masse: 5,979 · 10 ^ 24 kg"
	description.Density = "Dichte: 5,515 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: 150 000 000 km"
	description.Diameter = "Durchmesser: 12 757 km"
	description.AroundSun = "Umlaufzeit um Sonne: 365 Tage"
	description.AroundSelf = "Achsrotation: 1 Tag"
	TPlanet.Create("Erde"    , -0.3305873*SSF,   0.8497269*SSF,   0.3684325*SSF, -0.016483420 , -0.005365460 , -0.002326460 , 5.979*10^24, Img_Earth, color, description)
	
	
	' Mars
	color = TRGB.Create( 255 ,   0 ,   0)
	description = New TPlanetDescription
	description.Mass = "Masse: 6,418 · 10 ^ 23 kg"
	description.Density = "Dichte: 3,933 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: 228 000 000 km"
	description.Diameter = "Durchmesser: 6787 km"
	description.AroundSun = "Umlaufzeit um Sonne: 687 Tage"
	description.AroundSelf = "Achsrotation: 1 Tag"
	TPlanet.Create("Mars"    , -1.5848092*SSF,  -0.3648638*SSF,  -0.1244522*SSF,  0.003821510 , -0.011241840 , -0.005259630 , 6.418*10^23, Img_Mars ,color, description)
	
	
	' Jupiter
	color = TRGB.Create( 128 , 255 ,   0)
	description = New TPlanetDescription
	description.Mass = "Masse: 1,901 · 10 ^ 27 kg"
	description.Density = "Dichte: 1,326 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: 778 000 000 km"
	description.Diameter = "Durchmesser: 142 870 km"
	description.AroundSun = "Umlaufzeit um Sonne: 12 Jahre"
	description.AroundSelf = "Achsrotation: 9 Std"
	TPlanet.Create("Jupiter" ,    4.1801700*SSF,  -2.5386080*SSF,  -1.1900210*SSF,  0.004106423 ,  0.006125327 ,  0.002525539 , 1.901*10^27, Img_Jupiter ,color, description)
	
	
	' Saturn
	color = TRGB.Create( 255 , 255 , 128)
	description = New TPlanetDescription
	description.Mass = "Masse: 5,684 · 10 ^ 26 kg"
	description.Density = "Dichte: 0,687 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: 1 426 000 000 km"
	description.Diameter = "Durchmesser: 120 670 km"
	description.AroundSun = "Umlaufzeit um Sonne: 29 Jahre"
	description.AroundSelf = "Achsrotation: 10 Std"
	TPlanet.Create("Saturn"  ,  -4.6197080*SSF,  -8.2374610*SSF,  -3.2033610*SSF,  0.004647751 , -0.002328957 , -0.001161564 , 5.684*10^26, Img_Saturn ,color, description)
	
	
	' Uranus
	color = TRGB.Create(  0 , 255 , 255)
	description = New TPlanetDescription
	description.Mass = "Masse: 8,682 · 10 ^ 25 kg"
	description.Density = "Dichte: 1,27 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: 2 870 000 000 km"
	description.Diameter = "Durchmesser: 51 000 km"
	description.AroundSun = "Umlaufzeit um Sonne:  84  Jahre"
	description.AroundSelf = "Achsrotation: 16 Std"
	TPlanet.Create("Uranus"  ,  -3.7245900*SSF, -17.1975200*SSF,  -7.4791700*SSF,  0.003833665 , -0.000845721 , -0.000424809 , 8.682*10^25, Img_Uranus ,color, description)
	
	
	' Neptun
	color = TRGB.Create(  0 , 128 , 255)
	description = New TPlanetDescription
	description.Mass = "Masse: 1,027 · 10 ^ 26 kg"
	description.Density = "Dichte: 1,638 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: 4 496 000 000 km"
	description.Diameter = "Durchmesser: 49 200 km"
	description.AroundSun = "Umlaufzeit um Sonne: 164 Jahre"
	description.AroundSelf = "Achsrotation: 16 Std"
	TPlanet.Create("Neptun"  ,   1.9138100*SSF, -27.9215500*SSF, -11.4762000*SSF,  0.003118271 ,  0.000233303 ,  0.000017967 , 1.027*10^26, Img_Neptun ,color, description)
	
	
	' Pluto
	color = TRGB.Create( 128 , 128 , 128)
	description = New TPlanetDescription
	description.Mass = "Masse: 1,080 · 10 ^ 24 kg"
	description.Density = "Dichte: 1,75 g/cm3"
	description.DistanceToSun = "Entfernung zur Sonne: 5 946 000 000 km"
	description.Diameter = "Durchmesser: 2 290 km"
	description.AroundSun = "Umlaufzeit um Sonne: 249 Jahre"
	description.AroundSelf = "Achsrotation: 5 Tage"
	TPlanet.Create("Pluto"   , -23.2285900*SSF, -18.5272000*SSF,   1.2167500*SSF,  0.002066577 , -0.002488884 , -0.001397200 , 1.080*10^24, Img_Pluto ,color, description)
End Function




Function ResetSolarSystem(visualizer:TVisualizer, solarParameter:TSolarPlanetParameter, solarTime:TSolarTime)
	For Local planet:TPlanet = EachIn TPlanet.List
		planet.Free()
	Next
	InitSolarSystem(visualizer)
	TPlanet.NormalizeWithSun(solarParameter.SunRealMass, solarParameter.SunNormalMass)
	solarTime.Reset()
	solarTime.ResetDate()
End Function


Function RemoveAllAsteroids()
	For Local planet:TPlanet = EachIn TPlanet.List
		If planet.Name = "Asteroid"
			planet.Free()
		End If
	Next
End Function


