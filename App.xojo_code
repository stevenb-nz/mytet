#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  wordsDB.Close
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  Window14x14.Enabled = true
		  Window10x10.Enabled = true
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  wordsDB = new SQLiteDatabase
		  wordsDB.DatabaseFile = SpecialFolder.Documents.Child("Words.sqlite")
		  if not wordsDB.CreateDatabaseFile then
		    MsgBox "Error connecting to Words database."
		  end
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function Window10x10() As Boolean Handles Window10x10.Action
			mainWindow10.show
			mainWindow14.Hide
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Window14x14() As Boolean Handles Window14x14.Action
			mainWindow10.Hide
			mainWindow14.Show
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Property, Flags = &h0
		wordsDB As SQLiteDatabase
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
