

Type TInput
	Field MouseHit1:Int
	Field MouseHit2:Int
	Field MouseHit3:Int
	
	Field MouseDown1:Int
	Field MouseDown2:Int
	Field MouseDown3:Int
	
	Field EscapeHit:Int
	Field EscapeDown:Int
	Field EnterHit:Int
	Field EnterDown:Int
	Field SpaceHit:Int
	Field SpaceDown:Int
	
	
	Method Update()
	
		MouseHit1 = MouseHit(1)
		MouseHit2 = MouseHit(2)
		MouseHit3 = MouseHit(3)
		
		MouseDown1 = MouseDown(1)
		MouseDown2 = MouseDown(2)
		MouseDown3 = MouseDown(3)
		
		EscapeHit = KeyHit(KEY_ESCAPE)
		EscapeDown = KeyDown(KEY_ESCAPE)
		
		EnterHit = KeyHit(KEY_ESCAPE)
		EnterDown = KeyDown(KEY_ESCAPE)
		
		SpaceHit = KeyHit(KEY_SPACE)
		SpaceDown = KeyDown(KEY_SPACE)
	End Method

End Type









