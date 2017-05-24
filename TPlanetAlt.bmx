







Type TPlanet

	Global List:TList = New TList
	Field Link:TLink
	
	Global Sunmass:Double = 1
	
	Field Name:String
	
	Field X:Double
	Field Y:Double
	Field VX:Double
	Field VY:Double
	Field Mass:Double
	
	Field Radius:Float
	
	Field Color:TRgb

	Function Create(name:String, x:Double, y:Double, vx:Double, vy:Double, mass:Double, color:TRgb, visualizer:TVisualizer)
		Local planet:TPlanet = New TPlanet
		planet.Name = name
		planet.X = ( x - visualizer.GraphicW/2 ) / visualizer.Zoom - visualizer.OffsetX
		planet.Y = ( y - visualizer.GraphicH/2 ) / visualizer.Zoom - visualizer.OffsetY
		planet.VX = vx
		planet.VY = vy
		planet.Mass = mass
		planet.Color = color
	End Function


	Method New()
		Self.Link = List.AddLast( Self )
	End Method
	
	Method Free()
	      If Self.Link
	        	Self.Link.Remove()
	         	Self.Link = Null
	      EndIf
	EndMethod
	
	
	
	Function UpdateAll(gauss:TGauss)
		Local deltaX:Float
		Local deltaY:Float
		Local distance:Float
		Local angle:Float
		Local f:Float
		Local fX:Float
		Local fY:Float
	
		For Local planet1:TPlanet = EachIn TPlanet.List
			' Neue Position Berechnen
			planet1.X = planet1.X + planet1.VX * gauss.TimeFactor
			planet1.Y = planet1.Y + planet1.VY * gauss.TimeFactor
			planet1.Radius = Sqr( planet1.Mass / Pi )
			
			For Local planet2:TPlanet = EachIn TPlanet.List
				If planet1 = planet2 Then Continue

				deltaX = planet2.X - planet1.X
				deltaY = planet2.Y - planet1.Y
				
				planet2.Radius = Sqr( planet2.Mass / Pi )
				distance = ( deltaX )^2 + ( deltaY )^2
				angle = ATan2( deltaY, deltaX )
				
				If Sqr(distance) < (planet1.Radius + planet2.Radius) Then
                  		Fusion( planet1, planet2)             
            		Else
               			f = (planet1.Mass * planet2.Mass) / (distance)
            		End If       
				
				fx = f * Cos( angle )
				fy = f * Sin( angle )
				' Neue Geschwindigkeit Berechnen
            		planet1.VX = planet1.VX + fx / planet1.Mass * gauss.TimeFactor
				planet1.VY = planet1.VY + fy / planet1.Mass * gauss.TimeFactor
				
			Next
		Next
	End Function
	
	
	Function RenderAll(visualizer:TVisualizer)
		Local size:Float
		Local xScreen:Float
		Local yScreen:Float
		For Local planet:TPlanet = EachIn TPlanet.List
			size = Sqr( planet.Mass / Pi ) * visualizer.Zoom 
			If size < 1 Then size = 1
			xScreen = visualizer.GraphicW/2 + ( visualizer.OffsetX + planet.X ) * visualizer.Zoom 
			yScreen = visualizer.GraphicH/2 + ( visualizer.OffsetY + planet.Y ) * visualizer.Zoom 
			SetColor planet.Color.R, planet.Color.G, planet.Color.B
			DrawOval xScreen - size, yScreen - size, size * 2, size * 2
			SetColor 255, 255, 255
			DrawText planet.Name, xScreen + 10, yScreen - 20
		Next
		SetColor 255, 255, 255
	End Function
	
	
	Function Fusion(planet1:TPlanet, planet2:TPlanet)
		planet1.VX = ( planet1.VX * planet1.Mass + planet2.VX * planet2.Mass ) / ( planet1.Mass + planet2.Mass )
		planet1.VY = ( planet1.VY * planet1.Mass + planet2.VY * planet2.Mass ) / ( planet1.Mass + planet2.Mass )
	
		planet1.X = planet1.X + ( planet2.X - planet1.X ) * planet2.Mass / ( planet1.Mass + planet2.Mass )
		planet1.Y = planet1.Y + ( planet2.Y - planet1.Y ) * planet2.Mass / ( planet1.Mass + planet2.Mass )
	
		planet1.Mass = planet1.Mass + planet2.Mass
		
		planet2.Free()
	End Function
	

End Type

