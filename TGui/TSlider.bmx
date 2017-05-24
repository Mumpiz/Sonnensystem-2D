


Type TSlider Extends TGuiObject
	Field MinValue:Float
	Field MaxValue:Float
	Field Value:Float
	Field Percent:Float
	Field Vertical:Byte = False

	
	Field SliderButton:TButton
	
	Function Create:TSlider(x:Float, y:Float, w:Float, h:Float, minValue:Float, maxValue:Float, value:Float, parent:TGuiObject = Null)
		Local slider:TSlider = New TSlider
		slider.X = x
		slider.Y = y
		slider.Width = w
		slider.Height = h
		slider.MinValue = minValue
		slider.MaxValue = maxValue
		slider.Value = value
		If w > h
			slider.Vertical = False
			slider.SliderButton = TButton.Create("", w/2 - (h/2)/2, h/2 - (h/2)/2, h/2, h/2, slider, Null)
		Else
			slider.Vertical = True
			slider.SliderButton = TButton.Create("", w/2 - (w/2)/2, h/2 - (w/2)/2, w/2, w/2, slider, Null)
		End If
		slider.ValueToPos(slider.Value)
		
		If parent <> Null
			slider.Parent = parent
			parent.ChildObjectList.AddLast( slider )
			slider.Active = parent.Active
			slider.Visible = parent.Visible
		End If
		Return slider
	End Function
	
	
	Method Draw()
		If Not Self.Visible Return
		
		' SliderRahmen
		If Self.Border = True
			SetColor 1, 1, 1
			DrawBorder( Self.X, Self.Y, Self.Width, Self.Height)
		End If
		
		' SliderFläche
		If Self.Active
			SetColor 56, 56, 56
		Else
			SetColor 30, 30, 30
		End If
		DrawRect Self.X+1, Self.Y+1, Self.Width-1, Self.Height-1

		' SliderButtonBahn
		If Self.Active
			SetColor 18, 18, 18
		Else
			SetColor 12, 12, 12
		End If
		If Self.Vertical
			DrawRect Self.X + 1 + (Self.Width-1)/2 - (Self.Width-1)/8, Self.Y + 1, (Self.Width-1)/4, Self.Height-1
		Else
			DrawRect Self.X + 1, Self.Y + 1 + (Self.Height-1)/2 - (Self.Height-1)/8, Self.Width-1, (Self.Height-1)/4
		End If
		
	End Method
	
	
	Method Update()
		If Not Self.Visible Return
		If Not Self.Active Return
		UpdateSliderButtonPosition()
		UpdatePercent()
		UpdateValue()
	End Method
	
	
	Method UpdateSliderButtonPosition()
		If Self.MouseOverMe Or Self.SliderButton.MouseOverMe
			If TGui.Inputs.MouseDown1
				If Self.Vertical
					Self.SliderButton.Y = Self.SliderButton.Y + MouseY() - Self.SliderButton.Y - Self.SliderButton.Height/2
					If Self.SliderButton.Y + Self.SliderButton.Height/2 < Self.Y
						Self.SliderButton.Y = Self.Y - Self.SliderButton.Height/2
					End If
					If Self.SliderButton.Y + Self.SliderButton.Height/2 > Self.Y + Self.Height
						Self.SliderButton.Y = Self.Y + Self.Height - Self.SliderButton.Height/2
					End If
				Else
					Self.SliderButton.X = Self.SliderButton.X + MouseX() - Self.SliderButton.X - Self.SliderButton.Width/2
					If Self.SliderButton.X + Self.SliderButton.Width/2 < Self.X
						Self.SliderButton.X = Self.X - Self.SliderButton.Width/2
					End If
					If Self.SliderButton.X + Self.SliderButton.Width/2 > Self.X + Self.Width
						Self.SliderButton.X = Self.X + Self.Width - Self.SliderButton.Width/2
					End If
				End If
			End If
		End If
	End Method
	
	
	Method UpdatePercent()
		If Self.Vertical
			Self.Percent = 100 - ( ( Self.SliderButton.Y + Self.SliderButton.Height/2 - Self.Y ) / Self.Height )  * 100
		Else
			Self.Percent = ( ( Self.SliderButton.X + Self.SliderButton.Width/2 - Self.X ) / Self.Width )  * 100
		End If
	End Method
	
	
	Method UpdateValue()
		Local difference:Float  = Self.MaxValue - Self.MinValue
		Local addPercent:Float  = ( Self.MinValue / difference ) * 100
		Self.Value = ( difference / 100 ) * ( Self.Percent + addPercent )
	End Method
	
	
	Method PercentToPos(percent:Float)
		Local difference:Float
		Local minVal:Float
		Local maxVal:Float
		If Self.Vertical
			percent = 100 - percent
			minVal = Self.Y
			maxVal = Self.Y + Self.Height
			difference = maxVal - minVal
			Self.SliderButton.Y = ( ( difference / 100 ) * percent ) - Self.SliderButton.Height/2
		Else
			minVal = Self.X
			maxVal = Self.X + Self.Width
			difference = maxVal - minVal
			Self.SliderButton.X = ( difference / 100 ) * percent - Self.SliderButton.Width/2
		End If
	End Method
	
	
	Method ValueToPos(value:Float)
		Local valueInPercent:Float = ( value / Self.MaxValue ) * 100
		PercentToPos(valueInPercent)
	End Method

End Type










