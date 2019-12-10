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
		  if MainWindow.undo.Ubound < 0 then
		    EditUndo.Enabled = false
		  else
		    EditUndo.Enabled = true
		  end
		  
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
		Function EditUndo() As Boolean Handles EditUndo.Action
			
			
			
			'newundoitem = new XYLetter
			'newundoitem.letter = grid(mdx-1+i*dx,mdy-1+i*dy)
			'newundoitem.x = mdx-1+i*dx
			'newundoitem.y = mdy-1+i*dy
			'undo.Append newundoitem
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

	#tag Constant, Name = tiles, Type = String, Dynamic = False, Default = \"AAAAAAAAABBCCDDDDEEEEEEEEEEEEFFGGGHHIIIIIIIIIJKLLLLMMNNNNNNOOOOOOOOPPQRRRRRRSSSSTTTTTTUUUUVVWWXYYZAAAAAAAAABBCCDDDDEEEEEEEEEEEEFFGGGHHIIIIIIIIIJKLLLLMMNNNNNNOOOOOOOOPPQRRRRRRSSSSTTTTTTUUUUVVWWXYYZ", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
