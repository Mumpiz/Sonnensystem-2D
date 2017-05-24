



Type TMusicHandler
	
	Field tmpMS:Int , MS:Int
	
	Field SongLength:Int = 180000
	
	Field Music:TSound, Channel:TChannel


	Function Create:TMusicHandler(music:TSound, channel:TChannel)
		Local musicH:TMusicHandler = New TMusicHandler
		musicH.Music = music
		musicH.Channel = channel
		musicH.tmpMS = MilliSecs() + 2000
		Return musicH
	End Function


	Method RePlay:Byte()
		Self.MS = MilliSecs()
		If Self.tmpMS < Self.MS
			Self.tmpMS = Self.MS + SongLength
			Return True
		End If
		Return False
	End Method
	
	Method Update()
		If RePlay()
			PlaySound Self.Music, Self.Channel
		End If
	End Method
	

End Type
