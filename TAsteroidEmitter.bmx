


Type TAsteroidEmitter
	Global List:TList = New TList
	Field Link:TLink
	
	Field StartX:Float
	Field StartY:Float
	Field StartSet:Byte = False

	Field endX:Float
	Field endY:Float
	
	Field VX:Float
	Field VY:Float
	Field VSet:Byte = False
	
	' Beschleunigungs-Variablen
	Field AX:Double
	Field AY:Double
	' Wegvector zwischen 2 Planeten
	Field XP2P1:Double
	Field YP2P1:Double
	' Der Abstand zwischen 2 Planeten
	Field Distance:Double
	' Der Abstand zwischen 2 Planeten hoch3
	Field Distance3:Double
	Field Coeff:Double
	
	Field AsteroidMass:Float
	
	Field AstroidColor:TRgb
	
	
	Function Create(mass:Double)
		Local emitter:TAsteroidEmitter = New TAsteroidEmitter
		emitter.AsteroidMass = mass
	End Function

	Method New()
		Self.List.Clear()
		Self.Link = List.AddLast( Self )
		Self.AstroidColor = TRgb.Create(91, 91, 91)
	End Method
	
	Method Free()
	      If Self.Link
	        	Self.Link.Remove()
	         	Self.Link = Null
	      EndIf
	EndMethod
	
	
	Method Draw(visualizer:TVisualizer)
		If Not TGui.MouseOverGui
			If startSet = False
				SetAlpha 0.5
				SetColor 200, 0, 0
				DrawOval(MouseX() - 4, MouseY() - 4, 8, 8)
				SetColor 255, 255, 255
				SetAlpha 1
			ElseIf startSet = True
				SetAlpha 0.5
				Local screenX:Float = SolarXToScreenX(StartX, visualizer)
				Local screenY:Float = SolarYToScreenY(StartY, visualizer)
				SetColor 200, 0, 0
				DrawOval(screenX - 4, screenY - 4, 8, 8)
				DrawLine screenX, screenY, MouseX(), MouseY()
				SetColor 255, 255, 255
				SetAlpha 1
			End If
		End if
	End Method
	
	
	Method Update(gui:TGui, inputs:TInput, visualizer:TVisualizer, gauss:TGauss, time:TSolarTime)
		If inputs.MouseHit1 And Not gui.MouseOverGui
			If startSet = False And VSet = False
				StartX = SolarPickedX(visualizer)
				StartY = SolarPickedY(visualizer)
				startSet = True
			ElseIf startSet = True And VSet = False
				EndX = SolarPickedX(visualizer)
				EndY = SolarPickedY(visualizer)
				
				XP2P1 = ( EndX - StartX ) / 200
				YP2P1 = ( EndY - StartY ) / 200
				
				VSet = True
			End If
		End If
		
		If startSet = True And VSet = True
			TPlanet.Create("Asteroid", StartX, StartY, 0, XP2P1, YP2P1, 0, AsteroidMass, Img_Asteroid, AstroidColor)
			Self.Free()
		End If
	End Method
	
	
	Function UpdateAsteroidEmitter(gui:TGui, inputs:TInput, visualizer:TVisualizer, gauss:TGauss, time:TSolarTime)
		For Local emitter:TAsteroidEmitter = EachIn TAsteroidEmitter.List
			emitter.Update(gui, inputs, visualizer, gauss, time)
			emitter.Draw(visualizer)
		Next
	End Function
	
End Type












