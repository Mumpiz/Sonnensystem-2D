


Type TRgb
	Field R:Byte
	Field G:Byte
	Field B:Byte
	
	Function Create:TRgb(r:Byte, g:Byte, b:Byte)
		Local color:TRgb = New TRgb
		color.R = r
		color.G = g
		color.B = b
		Return color
	End Function
	
	Function Random:TRgb()
		Local color:TRgb = New TRgb
		color.R = Rnd(0, 255)
		color.G = Rnd(0, 255)
		color.B = Rnd(0, 255)
		Return color
	End Function
End Type
