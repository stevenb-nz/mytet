#tag Window
Begin Window MainWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   481
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1632753663
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Word Crush"
   Visible         =   True
   Width           =   421
   Begin PushButton StartButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Start"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   321
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   441
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton ClearButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Clear"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   441
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Label infoLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   112
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "0 words, 0 letters max"
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   441
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   197
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  dim tempx, tempy as integer
		  
		  if StartButton.Enabled = false then
		    mdx = 0
		    mdy = 0
		    tempx = (x-1) \ 30 + 1
		    tempy = (y-1) \ 30 + 1
		    
		    if (x-1) mod 30 > 0 and (y-1) mod 30 > 0 and tempx > 0 and tempx < 15 and tempy > 0 and tempy < 15 then
		      mdx = tempx
		      mdy = tempy
		    end
		    return true
		  else
		    return false
		  end
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  dim dx,dy,i,j as integer
		  dim s as string
		  
		  if mdx > 0 and mdy > 0 then
		    mux = (x-1) \ 30 + 1
		    muy = (y-1) \ 30 + 1
		    j = max(abs(mdx - mux),abs(mdy - muy))
		    dx = Sign(mux - mdx)
		    dy = sign(muy - mdy)
		    
		    if (x-1) mod 30 > 0 and (y-1) mod 30 > 0 and mux > 0 and mux < 15 and muy > 0 and muy < 15 then
		      if j > 0 and (abs(mdx - mux)=abs(mdy - muy) or abs(mdx - mux)=0 or abs(mdy - muy)=0) then
		        for i = 0 to j
		          s = s + grid(mdx-1+i*dx,mdy-1+i*dy)
		        next
		        if isWord(s) then
		          handleGoodWord(s)
		        else
		          handleBadWord(s)
		        end
		      end
		    end
		  end
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  dim i,j as integer
		  
		  for i=1 to 14
		    for j=1 to 14
		      displayletter g,i,j,grid(i-1,j-1)
		    next
		  next
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub displayletter(g as graphics, x as integer, y as integer, letter as string)
		  g.foreColor = rgb(255,255,191)
		  g.fillrect x*30-28,y*30-28,27,27
		  g.foreColor = rgb(0,0,0)
		  g.TextFont="Courier"
		  g.TextSize=24
		  g.DrawString letter, x*30-25, y*30-9
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handleBadWord(letters as String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handleGoodWord(word as string)
		  dim dx,dy,i,j as integer
		  
		  unplaced = unplaced + word
		  j = max(abs(mdx - mux),abs(mdy - muy))
		  dx = Sign(mux - mdx)
		  dy = sign(muy - mdy)
		  for i = 0 to j
		    grid(mdx-1+i*dx,mdy-1+i*dy) = ""
		  next
		  updateLabel
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isWord(word as String) As Boolean
		  dim sql as string
		  sql = "SELECT * from Words WHERE Word='"+word+"'"
		  
		  dim data as RecordSet
		  data = app.wordsDB.SQLSelect(sql)
		  
		  if data.EOF then
		    return false
		  else
		    return true
		  end
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateLabel()
		  dim i, j, x, y, words, letters as integer
		  dim s as string
		  
		  for i = 1 to 14
		    x = i-1
		    for j = 1 to 13-x
		      y = j-1
		      if grid(x,y) <> "" then
		        s = grid(x+(j-1),y)
		        for y = j to 13-x
		          s=s+grid(x+y,y)
		          if isWord(s) then
		            words = words + 1
		            if len(s) > letters then
		              letters = len(s)
		            end
		          end
		        next
		      end
		    next
		    
		    'for j = 1 to 13
		    'y = j-1
		    'if grid(x,y) <> "" then
		    's = grid(x,y)
		    'for y = j to 13
		    's=s+grid(x,y)
		    'if isWord(s) then
		    'words = words + 1
		    'if len(s) > letters then
		    'letters = len(s)
		    'end
		    'end
		    'next
		    'end
		    'next
		    
		    for j = 1 to 13
		      y = j-1
		      if grid(x,y) <> "" then
		        s = grid(x-j,y)
		        for y = j to 13
		          s=s+grid(x-y,y)
		          if isWord(s) then
		            words = words + 1
		            if len(s) > letters then
		              letters = len(s)
		            end
		          end
		        next
		      end
		    next
		    
		    'x = 14-i
		    'for j = 1 to 13
		    'y = 14-j
		    'if grid(x,y) <> "" then
		    's = grid(x,y)
		    'for y = 13-j downto 0
		    's=s+grid(x,y)
		    'if isWord(s) then
		    'words = words + 1
		    'if len(s) > letters then
		    'letters = len(s)
		    'end
		    'end
		    'next
		    'end
		    'next
		    '
		    'y = i-1
		    'for j = 1 to 13
		    'x = j-1
		    'if grid(x,y) <> "" then
		    's = grid(x,y)
		    'for x = j to 13
		    's=s+grid(x,y)
		    'if isWord(s) then
		    'words = words + 1
		    'if len(s) > letters then
		    'letters = len(s)
		    'end
		    'end
		    'next
		    'end
		    'next
		    '
		    'y = 14-i
		    'for j = 1 to 13
		    'x = 14-j
		    'if grid(x,y) <> "" then
		    's = grid(x,y)
		    'for x = 13-j downto 0
		    's=s+grid(x,y)
		    'if isWord(s) then
		    'words = words + 1
		    'if len(s) > letters then
		    'letters = len(s)
		    'end
		    'end
		    'next
		    'end
		    'next
		  next
		  
		  infoLabel.Text = str(words) + " word" + if(words=1,", ","s, ")+ str(letters) + " letters max"
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		grid(13,13) As String
	#tag EndProperty

	#tag Property, Flags = &h0
		mdx As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		mdy As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		mux As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		muy As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		unplaced As String
	#tag EndProperty


#tag EndWindowCode

#tag Events StartButton
	#tag Event
		Sub Action()
		  dim temp(-1) As string
		  dim i,j as integer
		  
		  for i = 1 to 196
		    temp.Append mid(app.tiles,i,1)
		  next
		  
		  temp.Shuffle
		  for i=0 to 13
		    for j=0 to 13
		      grid(i,j) = temp.Pop
		    next
		  next
		  updateLabel
		  Refresh
		  me.Enabled = false
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClearButton
	#tag Event
		Sub Action()
		  dim i,j as Integer
		  
		  unplaced = ""
		  for i=0 to 13
		    for j=0 to 13
		      grid(i,j) = ""
		    next
		  next
		  StartButton.Enabled = true
		  Refresh
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="unplaced"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="mdx"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="mdy"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="mux"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="muy"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
