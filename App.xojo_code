#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  wordsDB.Close
		  
		  'save high score
		  
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
		  
		  ' load saved high score if present
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditUndo() As Boolean Handles EditUndo.Action
			dim i as integer
			dim item as UndoItem
			
			item = MainWindow.undo.pop
			
			for i = 0 to UBound(item.xyletters)
			if MainWindow.grid(item.xyletters(i).x,item.xyletters(i).y) = "" then
			MainWindow.unplaced = left(MainWindow.unplaced,len(MainWindow.unplaced)-1)
			end
			MainWindow.grid(item.xyletters(i).x,item.xyletters(i).y) = item.xyletters(i).letter
			next
			MainWindow.score = MainWindow.score - item.score
			MainWindow.updateLabels
			MainWindow.Refresh
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
