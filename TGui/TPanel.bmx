



' Gui Objekte

Type TPanel Extends TGuiObject

	Function Create:TPanel(x:Float, y:Float, w:Float, h:Float, parent:TGuiObject = Null)
		Local panel:TPanel = New TPanel
		panel.X = x
		panel.Y = y
		panel.LastX = x
		panel.LastY = y
		panel.Width = w
		panel.Height = h
		If parent<> Null
			panel.Parent = parent
			parent.ChildObjectList.AddLast( panel )
		End If
		Return panel
	End Function
	
	Method Draw()
		If Not Self.Visible Return
		' PanelRahmen
		If Border = True
			SetColor 1, 1, 1
			DrawBorder( Self.X, Self.Y, Self.Width, Self.Height )
		End If
		
		' PanelFläche
		SetColor 46, 46, 46
		DrawRect Self.X+1, Self.Y+1, Self.Width-1, Self.Height-1
	End Method
	
	Method Update()
		
	End Method
End Type
