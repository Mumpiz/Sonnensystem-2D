



Type TTabber Extends TGuiObject
	Field FirstTab:Byte = True
	
	Field TabButtonList:TList
	Field NewTabButtonX:Float = 0
	
	Function Create:TTabber(x:Float, y:Float, width:Float, height:Float, tabSide:Byte = 0, parent:TGuiObject = Null)
		Local tabber:TTabber = New TTabber
		tabber.X = x
		tabber.Y = y
		tabber.Width = width
		tabber.Height = height
		tabber.TabButtonList = New TList
		TPanel.Create(0, -2, tabber.Width, tabber.Height+2, tabber)
		If parent <> Null
			tabber.Parent = parent
			parent.ChildObjectList.AddLast( tabber )
			tabber.Active = parent.Active
			tabber.Visible = parent.Visible
		End If
		
		Return tabber
	End Function
	
	
	Method AddTab:TTab(name:String)
		Local tabButton:TButton = TButton.Create(name, Self.NewTabButtonX, -TextHeight(name), TextWidth(name)+8, TextHeight(name), Self)
		Self.NewTabButtonX = Self.NewTabButtonX + TextWidth(name)+8
		Self.TabButtonList.AddLast( tabButton )
		Local tab:TTab = TTab.Create(name, Self, tabButton)
		If Self.FirstTab
			tab.Visible = True
			HighlightTabberButton(tab.TabberButton, False)
			Self.FirstTab = False
		Else
			tab.Visible = False
		End If
		Return tab
	End Method
	
	
	Method Draw()

	End Method
	
	Method Update()
	End Method
	
End Type



Type TTab Extends TGuiObject
	Field Text:String
	Field TabPanel:TPanel
	Field TabberButton:TButton
	
	
	Function Create:TTab(name:String, parent:TTabber, tabberButton:TButton)
		Local tab:TTab = New TTab
		tab.Text = name
		tab.Parent = parent
		tab.TabberButton = tabberButton
		tab.Width = parent.Width
		tab.Height = parent.Height
		parent.ChildObjectList.AddLast( tab )
		tab.Active = parent.Active
		tab.Visible = parent.Visible
		Return tab
	End Function
	
	
	Method Draw()
	End Method
	
	Method Update()
		UpdateTabVisibility()
	End Method
	
	
	Method UpdateTabVisibility()
		If Self.TabberButton.IsPressed()
			If Self.Visible = False
				HighlightTabberButton(Self.TabberButton, False)
				Self.Visible = True
				HideOtherTabs(Self)
			End If
		End If
	End Method
	
	Method HideOtherTabs(except:TTab)
		For Local tab:TTab = EachIn Self.Parent.ChildObjectList
			If tab <> except
				If tab.Visible = True
					tab.Visible = False
					HighlightTabberButton(tab.TabberButton, True)
				End If
			End If
		Next
	End Method
	
	
	

End Type



Function HighlightTabberButton(button:TButton, deHighlight:Byte)
	If Not deHighlight
		button.Y = button.Y - 3
		button.X = button.X - 3
		button.Width = button.Width + 3
	Else
		button.Y = button.Y + 3
		button.X = button.X + 3
		button.Width = button.Width - 3
	End If		
End Function





