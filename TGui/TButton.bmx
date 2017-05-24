


Type TButton Extends TGuiObject
	Field Text:String
	Field Image:TImage
	
	Function Create:TButton(text:String = "", x:Float, y:Float, w:Float, h:Float, parent:TGuiObject = Null, image:TImage = Null)
		Local button:TButton = New Tbutton
		If text <> Null
			button.Text = text
		End If
		button.X = x
		button.Y = y
		button.Width = w
		button.Height = h
		If image <> Null Then button.Image = image
		If parent <> Null
			button.Parent = parent
			parent.ChildObjectList.AddLast( button )
			button.Active = parent.Active
			button.Visible = parent.Visible
		End If
		Return button
	End Function
	
	Method Draw()
		If Not Self.Visible Return
		' ButtonRahmen
		If Self.Border = True
			SetColor 1, 1, 1
			DrawBorder( Self.X, Self.Y, Self.Width, Self.Height )
		End If
			
		' ButtonFläche
		If Self.MouseOverMe And Self.Active
			SetColor 120, 120, 120
		ElseIf Not Self.Active
			SetColor 50, 50, 50
		Else
			SetColor 90, 90, 90
		End If
		DrawRect Self.X+1, Self.Y+1, Self.Width-1, Self.Height-1
			
		' Buttonimage
		If Self.Image <> Null
			If MouseOverMe And Self.Active
				SetColor 255, 255, 255
			ElseIf Not Self.Active
				SetColor 100, 100, 100
			Else
				SetColor 220, 220, 220
			End If
			DrawImage( Self.Image, Self.X + Self.Width/2 - ImageWidth(Self.Image)/2 + 1, Self.Y + Self.Height/2 - ImageHeight(Self.Image)/2 + 1 )
		End If
			
		' ButtonText
		If Self.Text <> "" Or Self.Text <> Null
			If Self.Active
				SetColor 255, 255, 255
			Else
				SetColor 100, 100, 100
			End If
			DrawText Self.Text, Self.X + Self.Width/2 - TextWidth(Self.Text)/2, Self.Y + Self.Height/2 - TextHeight(Self.Text)/2 + 2
		End If
	End Method

	Method IsPressed:Byte()
		If Self.Visible
			If Self.Active
				If Self.MouseOverMe
					If TGui.Inputs.MouseHit1
						Return True
					End If
				End If
			End If
		End If
	End Method
	
	Method Update()
	
	End Method
End Type




