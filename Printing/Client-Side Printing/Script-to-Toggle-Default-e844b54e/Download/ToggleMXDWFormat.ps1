Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force

if(!(test-path "hklm:\software\policies\Microsoft\Windows NT\Printers"))
{
	New-Item -Path "hklm:\software\policies\Microsoft\Windows NT\Printers"
}

try
{	
	New-ItemProperty "hklm:\software\policies\Microsoft\Windows NT\Printers\" -Name "MXDWUseLegacyOutputFormatMSXPS" -Value 0 -PropertyType "DWORD" -ErrorAction SilentlyContinue
}
finally
{
	$KeyValue = (Get-ItemProperty -Path "hklm:\software\policies\Microsoft\Windows NT\Printers" -Name "MXDWUseLegacyOutputFormatMSXPS")."MXDWUseLegacyOutputFormatMSXPS"

	if($KeyValue) 
	{
		Set-ItemProperty -Path "hklm:\software\policies\Microsoft\Windows NT\Printers" -Name "MXDWUseLegacyOutputFormatMSXPS" -Value 0
	}
	else
	{
		Set-ItemProperty -Path "hklm:\software\policies\Microsoft\Windows NT\Printers" -Name "MXDWUseLegacyOutputFormatMSXPS" -Value 1
	}
}

	



