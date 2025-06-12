' Usage:
'
' cscript <name_of_file>.vbs
'
' script by dumpydooby
' modded by ricktendo64
' updated by abbodi1406
Option Explicit
Dim ws, installer, fs, db, view, record, x, sProperty
Set ws = WScript.CreateObject("WScript.Shell")
Set fs = CreateObject("Scripting.FileSystemObject")
Set installer = WScript.CreateObject("WindowsInstaller.Installer")
If WScript.Arguments.Count <> 0 Then
	For each x in WScript.Arguments
		ProcessMSI x
	Next
Else
	If fs.FileExists("vc_red.msi") Then ProcessMSI "vc_red.msi"
End If
'**********************************************************************
'** Function; Fetch Property value from MSI database                                     **
'**********************************************************************
Function GetProperty(query)
	GetProperty = ""
	On Error Resume Next
	Set view = db.OpenView("SELECT `Value` FROM Property WHERE `Property` = '"&query&"'") : CheckError
	view.Execute : CheckError
	Set record = view.Fetch : CheckError
	GetProperty = record.StringData(1)
	view.Close
	Set view = nothing
	Set record = nothing
End Function
'**********************************************************************
'** Function; Query MSI database                                     **
'**********************************************************************
Function QueryDatabase(arrOpts)
	On Error Resume Next
	Dim query, file, binary : binary = false
	If LCase(TypeName(arrOpts)) = "string" Then
		query = arrOpts
	Else
		If fs.FileExists(arrOpts(0)) Then
			file = arrOpts(0)
			query = arrOpts(1)
		Else
			query = arrOpts(0)
			file = arrOpts(1)
		End If
		binary = true
	End If
	WScript.Echo query
	If binary Then
		Set record = installer.CreateRecord(1)
		record.SetStream 1, file
	End If
	Set view = db.OpenView (query) : CheckError
	If binary Then
		view.Execute record : CheckError
	Else
		view.Execute : CheckError
	End If
	view.close
	Set view = nothing
	If binary Then Set record = nothing
	binary = false
'	db.commit : CheckError
End Function
'**********************************************************************
'** Subroutine; Check errors in most recently executed MSI command   **
'**********************************************************************
Sub CheckError
	Dim message, errRec
	If Err = 0 Then Exit Sub
	message = Err.Source & " " & Hex(Err) & ": " & Err.Description
	If Not installer Is Nothing Then
		Set errRec = installer.LastErrorRecord
		If Not errRec Is Nothing Then message = message & vbNewLine & errRec.FormatText
	End If
	Wscript.Echo "" : Wscript.Echo message : Wscript.Echo ""
	Wscript.Quit 2
End Sub
'**********************************************************************
'** Function; Push changes to MSI                                    **
'**********************************************************************
Function ProcessMSI(file)
	Set db = installer.OpenDatabase(file, 1)
	On Error Resume Next
	sProperty = GetProperty("ProductVersion")
	If Not Left(sProperty, 3) = "10." Then Exit Function
	Wscript.Echo ""
	QueryDatabase("DELETE FROM `Component` WHERE `Directory_` = 'CSetupMM_URT_amd64.3643236F_FC70_11D3_A536_0090278A1BB8'")
	QueryDatabase("DELETE FROM `Component` WHERE `Directory_` = 'CSetupMM_URT_x86.3643236F_FC70_11D3_A536_0090278A1BB8'")
	QueryDatabase("DELETE FROM `Component` WHERE `Directory_` = 'DR_54322.3643236F_FC70_11D3_A536_0090278A1BB8'")
	QueryDatabase("DELETE FROM `Directory` WHERE `Directory` = 'CSetupMM_URT_amd64.3643236F_FC70_11D3_A536_0090278A1BB8'")
	QueryDatabase("DELETE FROM `Directory` WHERE `Directory` = 'CSetupMM_URT_x86.3643236F_FC70_11D3_A536_0090278A1BB8'")
	QueryDatabase("DELETE FROM `Directory` WHERE `Directory` = 'DR_54322.3643236F_FC70_11D3_A536_0090278A1BB8'")
	QueryDatabase("DELETE FROM `CreateFolder` WHERE `Directory_` = 'CSetupMM_URT_amd64.3643236F_FC70_11D3_A536_0090278A1BB8'")
	QueryDatabase("DELETE FROM `CreateFolder` WHERE `Directory_` = 'CSetupMM_URT_x86.3643236F_FC70_11D3_A536_0090278A1BB8'")
	QueryDatabase("DELETE FROM `CreateFolder` WHERE `Directory_` = 'DR_54322.3643236F_FC70_11D3_A536_0090278A1BB8'")
	QueryDatabase("DELETE FROM `Feature` WHERE `Feature` = 'VC_RED_enu_amd64_net_SETUP'")
	QueryDatabase("DELETE FROM `Feature` WHERE `Feature` = 'VC_RED_enu_x86_net_SETUP'")
	QueryDatabase("DELETE FROM `FeatureComponents` WHERE `Feature_` = 'VC_RED_enu_amd64_net_SETUP'")
	QueryDatabase("DELETE FROM `FeatureComponents` WHERE `Feature_` = 'VC_RED_enu_x86_net_SETUP'")
	QueryDatabase("DELETE FROM `FeatureExtensionData` WHERE `FeatureId` = 'VC_RED_enu_amd64_net_SETUP'")
	QueryDatabase("DELETE FROM `FeatureExtensionData` WHERE `FeatureId` = 'VC_RED_enu_x86_net_SETUP'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_NonInstall_Globdata_ini'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_NonInstall_Install_ini_enu'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_chs'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_cht'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_deu'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_enu'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_esn'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_fra'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_ita'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_jpn'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_kor'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_EUAL_txt_rus'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_Install_exe_amd64'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_Install_exe_x86'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_MSI_amd64_enu'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_MSI_x86_enu'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_VCRedist_Bmp'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_VC_Redist_Noninstall_VCRedist_CAB'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_chs'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_cht'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_deu'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_enu'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_esn'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_fra'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_ita'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_jpn'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_kor'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_amd64_rus'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_chs'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_cht'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_deu'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_enu'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_esn'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_fra'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_ita'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_jpn'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_kor'")
	QueryDatabase("DELETE FROM `File` WHERE `File` = 'F_install_res_1033_dll_x86_rus'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_NonInstall_Globdata_ini'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_NonInstall_Install_ini_enu'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_chs'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_cht'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_deu'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_enu'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_esn'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_fra'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_ita'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_jpn'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_kor'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_EUAL_txt_rus'")
	QueryDatabase("DELETE FROM `MsiFileHash` WHERE `File_` = 'F_VC_Redist_Noninstall_VCRedist_Bmp'")
	sProperty = GetProperty("ProductCPU")
	If LCase(sProperty) = "x86" Then
		QueryDatabase("INSERT INTO `Registry` (`Registry`,`Root`,`Key`,`Name`,`Value`,`Component_`) VALUES ('Servicing_Key_ProductEdition_RegKey_8','2','SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\[ProductCode]','DisplayIcon','[SystemFolder_x86_VC]msiexec.exe,0','Servicing_Key_ProductEdition')")
	Else
		QueryDatabase("INSERT INTO `Component` (`Component`,`ComponentId`,`Directory_`,`Attributes`,`Condition`,`KeyPath`) VALUES ('Servicing_Key_ProductEdition_amd64','{D17E22FF-7492-48E1-867B-5CDEAB89CDCD}','TARGETDIR',260,Null,'Servicing_Key_ProductEdition_RegKey_8')")
		QueryDatabase("INSERT INTO `FeatureComponents` (`Feature_`,`Component_`) VALUES ('Servicing_Key','Servicing_Key_ProductEdition_amd64')") 
		QueryDatabase("INSERT INTO `Registry` (`Registry`,`Root`,`Key`,`Name`,`Value`,`Component_`) VALUES ('Servicing_Key_ProductEdition_RegKey_8','2','SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\[ProductCode]','DisplayIcon','[System64Folder_amd64_VC]msiexec.exe,0','Servicing_Key_ProductEdition_amd64')")
	End If
	db.commit : CheckError
	Set db = nothing
End Function