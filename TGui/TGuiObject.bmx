

' Abstracte Hauptklasse eines Gui-Objektes wie zB. einem Button

Type TGuiObject Abstract
	Field FirstInit:Byte = True

	Field ChildObjectList:TList
	
	Field Parent:TGuiObject
	
	Field Border:Byte = True
	
	Field MouseOverMe:Byte
	
	Field Link:TLink
	Field X:Float
	Field Y:Float
	Field LastX:Float
	Field LastY:Float
	Field Width:Int
	Field Height:Int
	
	Field Active:Byte = True
	Field Visible:Byte = True
	Field LastActive:Byte = Active
	Field LastVisible:Byte = Visible
	
	Field TooltipText:String
	
	Method Draw() Abstract
	Method Update() Abstract

	
	Method New()
		Self.ChildObjectList = New TList
		Self.Link = TGui.GuiObjectList.AddLast( Self )
	End Method
	
	Method Free()
	      If Self.Link
			For Local cObject:TGuiObject = EachIn ChildObjectList
				cObject.Free()
			Next
			Self.ChildObjectList.Clear()
	        	Self.Link.Remove()
	         	Self.Link = Null
	      EndIf
	EndMethod
	
	
	Method UpdateGuiObjects()
		UpdateMouseOverMe()
		UpdateChildObjectCoords()
		UpdateChildObjectFlags()
		Self.FirstInit = False
	End Method
	
	
	Method IsMouseOver:Byte()
		If RectsOverlap:Byte(Self.X, Self.Y, Self.Width, Self.Height, MouseX(), MouseY(), 1, 1) Then Return True
	End Method
	
	Method UpdateMouseOverMe()
		If IsMouseOver()
			MouseOverMe = True
		Else
			MouseOverMe = False
		End If
	End Method
	
	Method UpdateChildObjectCoords()
		If Self.FirstInit
			For Local cObject:TGuiObject = EachIn Self.ChildObjectList
				cObject.X = cObject.X + Self.X
				cObject.Y = cObject.Y + Self.Y
			Next
			Self.LastX = Self.X
			Self.LastY = Self.Y
		Else
			If Self.X <> Self.LastX Or Self.Y <> Self.LastY
				For Local cObject:TGuiObject = EachIn Self.ChildObjectList
					cObject.X = cObject.X + Self.X - Self.LastX
					cObject.Y = cObject.Y + Self.Y - Self.LastY
				Next
				Self.LastX = Self.X
				Self.LastY = Self.Y
			End If
		End If
	End Method
	
	Method UpdateChildObjectFlags()
		If Self.Active <> Self.LastActive Or Self.Visible <> Self.LastVisible
			If Self.FirstInit
				Self.LastActive = Self.Active
				Self.LastVisible = Self.Visible	
			End If
			For Local cObject:TGuiObject = EachIn Self.ChildObjectList
				cObject.Active = Self.Active
				cObject.Visible = Self.Visible
			Next
			Self.LastActive = Self.Active
			Self.LastVisible = Self.Visible
		End If
	End Method
	
	Method UpdateToolTips(maxWidth:Int)
		If Self.MouseOverMe
			If Self.Tooltiptext <> Null And Self.Tooltiptext <> ""
				Local x:Float
				Local y: Float
				Local width:Float = TextWidth(Self.Tooltiptext)
				Local height:Float
				
				If TextWidth(Self.Tooltiptext) < maxWidth
					height = TextHeight(Self.Tooltiptext)
					width = TextWidth(Self.Tooltiptext) + 2
				Else
					height = ( width / maxWidth ) * TextHeight(Self.Tooltiptext)
					width = maxWidth
				End If
				
				If MouseX() + width > GraphicsWidth()
					x = MouseX() - width
				Else
					x = MouseX()
				End If
				
				If MouseY() + height + TextHeight(Self.Tooltiptext) >= GraphicsHeight()
					y = MouseY() - height
				Else
					y = MouseY() + TextHeight(Self.Tooltiptext) + 2
				End If
				
				SetColor 250, 255, 180
				DrawRect x-2, y-1, width+3, height+2
				SetColor 1, 1, 1
				DrawBorder(x-2, y-1, width+3, height+2)
				DrawTextFormated(Self.Tooltiptext, x, y, width, height, False)
			End If
		End If
	End Method
	
End Type




Function DrawTextFormated(text:String, x:Float, y:Float, width:Int, height:Int, centered:Byte, currentYPos:Int = 0)
	
	Local txtHeight:Int = TextHeight(text)
	
	currentYPos = currentYPos + 1
	
	If TextWidth( text ) < width Then
		DrawText( text, x, y )
	Else
	
		 For Local char:Int = 0 To Len(text) - 1
			If TextWidth( Left( text, char ) ) > width
		            Repeat
					char = char - 1
		            Until IsAbleToWrap( Mid( text, char, 1 ) )
		
				
				If currentYPos * txtHeight > height Then Exit
				If centered
					DrawText ( Left(text, char) , x + width/2 - TextWidth( Left(text, char) ) / 2 , y )
				Else
					DrawText ( Left(text, char), x , y )
				End If
		
		            DrawTextFormated( Trim( Right( text, Len( text ) - char ) ), x, y + txtHeight, width, height, centered, currentYPos)
	            	Exit
	         End If
	      Next
   	End If
End Function


Function IsAbleToWrap:Byte(char$) 
	Select char
      	Case ".", ",", ";", ":", "!", "?", "-", " "
         		Return True
      	Default
         	Return False
	End Select
End Function






