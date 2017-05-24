
' Der (S)onnensystem(S)kalierungs(F)aktor (Um die Größenverhältnisse besser darzustellen)
Const SSF:Int = 1



Type TSolarTime
	Const DAYS_PER_YEAR:Double = 365.2425
	Const DAYS_PER_MONTH:Double = DAYS_PER_YEAR / 12

	Field TimeFactor:Double = 0
	Field Time:Double = 0
	Field TimeStep:Double = 1
	
	Field MS:Int, tmpMS:Int
	Field CalculationsPerSecond:Int = 32
	
	Field Days:Int
	Field Months:Int
	Field Years:Float
	Field DaysPerSecond:Int
	Field MonthsPerSecond:Int
	Field YearsPerSecond:Int
	
	Field Date:TSolarDate = New TSolarDate
	
	
	Method Reset()
		Self.TimeFactor = 0
		Self.Time = 0
		Self.TimeStep = 1
	End Method
	
	Method ResetDate()
		Self.Date.Reset()
	End Method
	
	Method Update()
		Self.Time = Self.Time + Self.TimeFactor / SSF
		If Self.TimeFactor < 1 Then Self.TimeStep = Self.TimeFactor Else Self.TimeStep = 1
		
		Self.Days = Int(Self.Time)
		Self.Months = Self.Time / DAYS_PER_MONTH
		Self.Years = Self.Time / DAYS_PER_YEAR
		Self.DaysPerSecond = Int( Self.TimeFactor * CalculationsPerSecond)
		Self.MonthsPerSecond = DaysPerSecond / 30
		Self.YearsPerSecond = DaysPerSecond / 365
	End Method
	
	Method ChangeSpeed(increaseKey:Int, decreaseKey:Int)
		If decreaseKey
			If Self.TimeFactor <= 1 
				Self.TimeFactor = Self.TimeFactor - 0.1
			Else
				If Self.TimeFactor - 1 < 1
					Self.TimeFactor = 1
				Else
					Self.TimeFactor = Self.TimeFactor - 1
				End If
			End If
			
			If Self.TimeFactor < 0 Then Self.TimeFactor = 0
		End If
		If increaseKey
			If Self.TimeFactor < 1
				Self.TimeFactor = Self.TimeFactor + 0.1 
			Else 
				Self.TimeFactor = Self.TimeFactor + 1
			End If
			If Self.TimeFactor > 100 Then Self.TimeFactor = 100
		End If
	End Method
	
	Method Recalculate:Byte()
		If CalculationsPerSecond > 1000 Then CalculationsPerSecond = 1000
		Self.MS = MilliSecs()
		If Self.tmpMS < Self.MS
			Self.tmpMS = Self.MS + (1000 / CalculationsPerSecond)
			Return True
		End If
		Return False
	End Method
	
	
	Method UpdateSolarSystem(gauss:TGauss)
		If Self.Recalculate()
		If Self.TimeFactor > 1
			For Local i:Int = 0 To Self.TimeFactor - 1
				TPlanet.UpdateAll(gauss, Self)
			Next
		Else
			TPlanet.UpdateAll(gauss, Self)
		End If
		Self.Update()
		Self.Date.Update(Self)
	End If
	End Method
	
End Type



Type TSolarDate
	Field Day:Int = 1
	Field Month:Int = 1
	Field Year:Int = 2000
	
	Field PassedDays:Double
	
	'Rem
	Method Update(time:TSolarTime)
		Self.Year = ( Int(time.Time) / 360 ) + 2000
		Self.Month = ( Int(time.Time) / 30 Mod 12 ) + 1
		Self.Day = ( Int(time.Time) Mod 30 ) + 1
	End Method
	'End Rem
	
	Rem
	Method Update(time:TSolarTime)
		Self.Day = time.Time - Self.PassedDays
		If Self.Day > TSolarTime.DAYS_PER_MONTH
			Self.Day = 1
			Self.Month = Self.Month + 1
			Self.PassedDays = Self.PassedDays + 30
		End If
		If Self.Month > 12
			Self.Year = Self.Year + 1
			Self.Month = 1
		End If
	End Method
	End Rem
	
	Method Reset()
		Self.Day:Int = 1
		Self.Month:Int = 1
		Self.Year:Int = 2000
	End Method
	
	Method Date:String()
		Return String(Int(Self.Day) + "." + Int(Self.Month) + "." + Int(Self.Year))
	End Method
End Type









