



Function UpdatePlanetSelection(inputs:TInput, visualizer:TVisualizer)
	If Not TGui.MouseOverGui
		If inputs.MouseHit1
			For Local planet:TPlanet = EachIn TPlanet.List
				planet.UpdateSelection(visualizer)
			Next
		End If
	End If
End Function