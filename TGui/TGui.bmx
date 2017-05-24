
' Farben
'rgb 56 = aktiv
'rgb 33 = inaktiv
'rgb 81 = mouse over

Include "TGuiObject.bmx"
Include "TButton.bmx"
Include "TPanel.bmx"
Include "TCheckBox.bmx"
Include "TTextBox.bmx"
Include "TSlider.bmx"
Include "TTabber.bmx"


' Gui Hauptklasse

Type TGui

	Global Inputs:TInput
	Field MSCounter:Float
	Field UpdatesPerSecond:Int = 80

	Global GuiObjectList:TList = New TList
	
	Global MouseOverGui:Byte
	
	Field ShowToolTips:Byte = True
	Field TooltipLength:Int = 300
	Field Hide:Byte = False
	Field Alpha:Float = 1
	
	Function Create:TGui(inputH:TInput)
		Local gui:TGui = New TGui
		gui.Inputs = inputH
		Return gui
	End Function
	
	Method Draw()
		If Not Self.Hide
			SetAlpha Self.Alpha
			For Local guiObject:TGuiObject = EachIn GuiObjectList
				guiObject.Draw()
			Next
			For Local guiObject:TGuiObject = EachIn GuiObjectList
				If guiObject.Active And guiObject.Visible
					If Self.ShowToolTips Then guiObject.UpdateToolTips(Self.TooltipLength)
				End if
			Next	
			
			SetAlpha 1
			SetColor 255, 255, 255
		End If
	End Method
	
	Method Update()
		If Not Self.Hide
			If ReUpdate()
				Self.MouseOverGui = False
				For Local guiObject:TGuiObject = EachIn GuiObjectList
					guiObject.UpdateGuiObjects()
					guiObject.Update()
					If guiObject.MouseOverMe
						MouseOverGui = True
					End If
				Next
			End If
		End If
	End Method
	
	Method ReUpdate:Byte()
		Local ms:Float = MilliSecs()
		If Self.MSCounter < ms
			Self.MSCounter = ms + (1000 / UpdatesPerSecond)
			Return True
		End If
		Return False
	End Method
End Type




' Gui interne Hilfs-Funktionen

Function RectsOverlap:Byte(x1:Int, y1:Int, w1:Int, h1:Int, x2:Int, y2:Int, w2:Int, h2:Int)
	If x1 <= (x2 + w2) And y1 <= y2 + h2 And (x1 + w1) >= x2 And (y1 + h1) >= y2 Then Return True
	Return False
End Function

Function DrawBorder(x:Int, y:Int, width:Int, height:Int)
	' Oben
	DrawLine x, y, x + width, y
	' Unten
	DrawLine x, y + height, x + width, y + height
	' Links
	DrawLine x, y, x, y + height
	' Rechts
	DrawLine x + width, y, x + width, y + height
End Function



