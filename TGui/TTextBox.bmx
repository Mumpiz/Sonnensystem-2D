


Type TTextBox Extends TGuiObject
	Field Text:String
	Field TextCentered:Byte = False
	
	Function Create:TTextBox(text:String, x:Float, y:Float, width:Float, height:Float, textCentered:Byte = False, parent:TGuiObject = Null)
		Local textBox:TTextBox = New TTextBox
		textBox.Text = text
		textBox.X = x
		textBox.Y = y
		textBox.Width = width
		textBox.Height = height
		textBox.TextCentered = textCentered
		If parent <> Null
			parent.ChildObjectList.AddLast( textBox )
			textBox.Active = parent.Active
			textBox.Visible = parent.Visible
		End If
		Return textBox
	End Function
	
	
	Method Draw()
		If Not Self.Visible Return
		' TextAreaRahmen
		If Self.Border = True
			SetColor 1, 1, 1
			DrawBorder( Self.X, Self.Y, Self.Width, Self.Height)
		End If
		
		' ButtonFläche
		If Self.Active
			SetColor 30, 30, 30
		Else
			SetColor 20, 20, 20
		End If
		DrawRect Self.X+1, Self.Y+1, Self.Width-1, Self.Height-1
		
		' TextAreaText
		If Self.Active
			SetColor 255, 255, 255
		Else
			SetColor 100, 100, 100
		End If
		DrawTextFormated(Self.Text, Self.X+4, Self.Y+4, Self.Width-8, Self.Height-8, Self.TextCentered)
	End Method
	
	Method Update()

	End Method

	

End Type








