



Type TVisualizer
	Field GraphicW:Int = 1024
	Field GRaphicH:Int = 768
	Field Zoom:Float
	Field OffsetX:Float = 0
	Field OffsetY:Float = 0
	
	Field XRotation:Float = 0
	
	Field SolarCenterX:Float = 0
	Field SolarCenterY:Float = 0
	
	Field MouseSpeedX:Int
	Field MouseSpeedY:Int
	Field MouseSpeedZ:Int
	
	Function Create:TVisualizer(gw:Int, gh:Int, zoom:Float = 260, offX:Float = 0, offY:Float = 0)
		Local vis:TVisualizer = New TVisualizer
		vis.GraphicW = gw
		vis.GraphicH = gh
		vis.Zoom = zoom
		vis.OffsetX = offX
		vis.OffsetY = offY
		Return vis
	End Function
	
	
	Method Update(inputs:TInput)
			Self.MouseSpeedX = MouseXSpeed()
			Self.MouseSpeedY = MouseYSpeed()
	
			If inputs.MouseDown2
				Self.OffsetX = Self.OffsetX + MouseSpeedX
				Self.OffsetY = Self.OffsetY + MouseSpeedY
				
				'Self.XRotation = Self.XRotation + Float(MouseSpeedY)/200
				If Self.XRotation < 0 Then Self.XRotation = 0
				If Self.XRotation > 1 Then Self.XRotation = 1
			End If

			
			Self.Zoom = Self.Zoom + Float(MouseZSpeed()) * ( Self.Zoom/10 )
			If Self.Zoom < 1 Self.Zoom = 1
			If Self.Zoom > 1000000 Self.Zoom = 1000000
			
	End Method
	
	Rem
	Method CenterToPlanet(planet:TPlanet)
		Self.OffsetX = -planet.ScreenX '- Self.GraphicW/2' - Self.OffsetX
		Self.OffsetY = -planet.ScreenY '- Self.GraphicH/2' - Self.OffsetY
	End Method
	
	Self.ScreenX = ( Self.X * visualizer.Zoom ) + visualizer.OffsetX + visualizer.GraphicW/2
   	Self.ScreenY = ( Self.Y * visualizer.Zoom ) + visualizer.OffsetY + visualizer.GraphicH/2
	
	End Rem
	
	Method CenterToPlanet(planet:TPlanet)
		Self.OffsetX = ScreenX(Planet.X, Self) - Self.OffsetX - Self.GraphicW/2
		Self.OffsetY = ScreenY(Planet.Y, Self) - Self.OffsetY - Self.GraphicH/2
	End Method


	Method ResetView()
		TPlanet.DeselectAll()
		Self.OffsetX = 0
		Self.OffsetY = 0
		Self.Zoom = 260
	End Method


End Type


Function SolarPickedX:Double(visualizer:TVisualizer)
	Return ( -visualizer.OffsetX - visualizer.GraphicW/2 + MouseX() ) / visualizer.Zoom
End Function


Function SolarPickedY:Double(visualizer:TVisualizer)
	Return ( -visualizer.OffsetY - visualizer.GraphicH/2 + MouseY() ) / visualizer.Zoom
End Function


Function SolarX:Double(x:Double, visualizer:TVisualizer)
	Return ( -visualizer.OffsetX - visualizer.GraphicW/2 + x ) / visualizer.Zoom
End Function


Function SolarY:Double(y:Double, visualizer:TVisualizer)
	Return ( -visualizer.OffsetY - visualizer.GraphicH/2 + y ) / visualizer.Zoom
End Function

Function ScreenX:Double(solarX:Double, visualizer:TVisualizer)
	Return ( -solarX * visualizer.Zoom ) + visualizer.OffsetX + visualizer.GraphicW/2
End Function

Function ScreenY:Double(solarY:Double, visualizer:TVisualizer)
	Return ( -solarY * visualizer.Zoom * visualizer.XRotation ) + visualizer.OffsetY + visualizer.GraphicH/2
End Function

Function SolarXToScreenX:Float(solarX:Double, visualizer:TVisualizer)
	Return  ( solarX * visualizer.Zoom ) + visualizer.OffsetX + visualizer.GraphicW/2
End Function

Function SolarYToScreenY:Float(solarY:Double, visualizer:TVisualizer)
	Return  ( solarY * visualizer.Zoom * visualizer.XRotation ) + visualizer.OffsetY + visualizer.GraphicH/2
End Function


Function GetDistance:Int(x1:Int, y1:Int, x2:Int, y2:Int)
	Return Sqr((x1 - x2)^2 + (y1-y2)^2)
EndFunction






