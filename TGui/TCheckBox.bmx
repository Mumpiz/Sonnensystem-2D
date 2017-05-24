


Type TCheckBox Extends TGuiObject
	Field State:Byte = False
	Field Text:String
	Field Image:TImage
	
	Function Create:TCheckBox(text:String = "", x:Float, y:Float, w:Float, h:Float, parent:TGuiObject = Null, image:TImage = Null)
		Local checkBox:TCheckBox = New TCheckBox
		If text <> Null
			checkBox.Text = text
		End If
		checkBox.X = x + TextWidth(text) + 4
		checkBox.Y = y
		checkBox.Width = w
		checkBox.Height = h
		If image <> Null Then checkBox.Image = image
		If parent <> Null
			parent.ChildObjectList.AddLast( checkBox )
			checkBox.Active = parent.Active
			checkBox.Visible = parent.Visible
		End If
		Return checkBox
	End Function
	
	Method Draw()
		If Not Self.Visible Return
			
		' ButtonRahmen ( Nur um Button )
		If Self.Border = True
			SetColor 1, 1, 1
			DrawBorder( Self.X, Self.Y, Self.Width, Self.Height )
		End If
			
		' ButtonFläche
		If MouseOverMe And Self.Active
			SetColor 80, 80, 80
		ElseIf Not Self.Active
			SetColor 30, 30, 30
		Else
			SetColor 56, 56, 56
		End If
		DrawRect Self.X+1, Self.Y+1, Self.Width-1, Self.Height-1
			
		' Buttonimage
		If Self.Image <> Null
			If MouseOverMe And Self.Active
				SetColor 255, 255, 255
			ElseIf Not Self.Active
				SetColor 100, 100, 100
			Else
				SetColor 200, 200, 200
			End If
			DrawImage( Self.Image, Self.X + Self.Width/2 - ImageWidth(Self.Image)/2, Self.Y + Self.Height/2 - ImageHeight(Self.Image)/2 , Self.State)
		End If
			
		' ButtonText
		If Self.Text <> "" Or Self.Text <> Null
			If Self.Active
				SetColor 255, 255, 255
			Else
				SetColor 100, 100, 100
			End If
			DrawText Self.Text, Self.X - TextWidth(Self.Text) - 4, Self.Y + Self.Height/2 - TextHeight(Self.Text)/2 + 2
		End If
			
		' Häckchen
		If Self.Image = Null
			If Self.State = True
				DrawText "x", Self.X + Self.Width/2 - TextWidth("x")/2, Self.Y + Self.Height/2 - TextHeight("x")/2 + 1
			End If
		End If
	End Method
	
	
	Method UpdateState()
		If Not Self.Visible Return
		If Not Self.Active Return
		If MouseOverMe
			If TGui.Inputs.MouseHit1
				Self.State = 1 - Self.State
			End If
		End If
	End Method
	
	
	Method Update()
		UpdateState()
	End Method
	
	

End Type



