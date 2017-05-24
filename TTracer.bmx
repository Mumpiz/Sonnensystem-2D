


' Der Schweif hinter einem Planeten
Type TTracer
	Field Length:Int
	Field ArrayPos:Int = 0
	Field Dot:TTracerDot[]
	
	Function Create:TTracer(arraylength:Int)
		Local tracer:TTracer = New TTracer
		tracer.Length = arraylength
		tracer.Dot = New TTracerDot[arraylength]
		Return tracer
	End Function
	
	Method CreateDot(x:Float, y:Float)
		If Self.ArrayPos > Self.Length - 1 Then Self.ArrayPos = 0
		Self.Dot[Self.ArrayPos] = TTracerDot.Create(x, y)
		Self.ArrayPos = Self.ArrayPos + 1
	End Method
	
	Method DrawUsingVisualizer(visualizer:TVisualizer)
		For Local i:Int = 0 To Self.Length - 1
			If Self.Dot[i] <> Null Then Self.Dot[i].DrawUsingVisualizer(visualizer)
		Next
	End Method
	
End Type

' Ein Schweifpunkt
Type TTracerDot
	Field X:Float
	Field Y:Float
	Field ScreenX:Float
	Field ScreenY:Float
	
	Function Create:TTracerDot(x:Float, y:Float)
		Local dot:TTracerDot = New TTracerDot
		dot.X = x
		dot.Y = y
		Return dot
	End Function
	
	Method DrawUsingVisualizer(visualizer:TVisualizer)
				Self.ScreenX =  ( Self.X  * visualizer.Zoom ) + visualizer.GraphicW/2 + visualizer.OffsetX
   		Self.ScreenY =  Self.Y  * visualizer.Zoom * visualizer.XRotation + visualizer.GraphicH/2 + visualizer.OffsetY
		'Self.ScreenX = ( Self.X * visualizer.Zoom ) + visualizer.OffsetX + visualizer.GraphicW/2
   		'Self.ScreenY = ( Self.Y * visualizer.Zoom ) + visualizer.OffsetY + visualizer.GraphicH/2

		Plot Self.ScreenX, Self.ScreenY
	End Method
End Type




