$PBExportHeader$u_service_file.sru
forward
global type u_service_file from nonvisualobject
end type
end forward

global type u_service_file from nonvisualobject
end type
global u_service_file u_service_file

type variables
PRIVATE:
boolean i_b_cache_downloads = true
end variables
forward prototypes
public function string of_get_temporary_download_location (string as_folder_name)
public function string of_get_filename_from_path (string as_path)
public function str_response of_download_file_from_url (string as_url, string as_download_location)
end prototypes

public function string of_get_temporary_download_location (string as_folder_name);/*
	of_get_temporary_download_location
	
	Locates the temporary folder location if available otherwise uses C
	returns string with folder locaion
*/

String   ls_values[]
String	s_uniq_path

if as_folder_name = '' then
	as_folder_name = 'PokemonImages'
end if

// Get Temporary Location
ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)
lcxk_base.GetContextKeywords("Temp", ls_values)
IF Upperbound(ls_values) > 0 THEN
	s_uniq_path = trim(ls_values[1])
	If right(s_uniq_path,1) <> '\' Then s_uniq_path += '\'
	s_uniq_path += as_folder_name
ELSE
	s_uniq_path = "c:\" + as_folder_name
END IF

// Create Folder if it does not exist
If NOT FileExists(s_uniq_path + '.') Then 
	CreateDirectory(s_uniq_path)
End If

return s_uniq_path
end function

public function string of_get_filename_from_path (string as_path);/*
	of_get_filename_from_path 	- 	returns filename from given path
											e.g. c:\something\test.jpg will return test.jpg
											returns empty string if no matches
											
											ab_include_last_folder - if true then will include the parent folder
											e.g. c:\something\test.jpg will return something\test.jpg
*/
String 	ls_filename
Long		ll_pos

ls_filename = ""

ll_pos = Pos(Reverse(as_path), "\")
if (ll_pos < 1 AND Pos(Reverse(as_path), "/") > 0) then
	ll_pos = Pos(Reverse(as_path), "/")
end if

if ll_pos > 0 then
	ls_filename = Right(as_path, ll_pos -1)
end if

return ls_filename
 
end function

public function str_response of_download_file_from_url (string as_url, string as_download_location);/*
	of_download_file_from_url
		Downloads a file from a URL to a given location. Works with HTTPS
		Based on winttp library by Topwiz, http://www.topwizprogramming.com/freecode_winhttp.html
		
		as_url - resource that you want to download (must end in a file extension)
		as_download_location - where the file should be downloaded to, if left blank will use temporary directory
*/
String 					ls_pathname, ls_filename
String					ls_temp_folder
Blob 						lblob_data
Integer 					li_fnum
Long						ll_pos
ULong 					lul_length
n_winhttp 				ln_http
str_response 			l_str_response

// Set Download Location - If as_download_location is blank use URL filename and temp directory by default
if (as_download_location = '') then
	ls_temp_folder 	=	this.of_get_temporary_download_location('')
	ls_filename			=	this.of_get_filename_from_path(as_url)

	If ls_filename = '' Then
		l_str_response.success = false
		l_str_response.message = "Unable to download as filename not recognised."
		return l_str_response
	End If

	ls_pathname = ls_temp_folder + '\' + ls_filename
else
	ls_pathname = 	as_download_location
end if

// Download File
if i_b_cache_downloads AND FileExists(ls_pathname) then
	
	// should check hash of file later but for moment if download exists just show it
	l_str_response.success = true
	l_str_response.result = ls_pathname 
	return l_str_response

else
	lul_length = ln_http.GetURL(as_url, lblob_data)	
end if


If lul_length > 0 Then
	li_fnum = FileOpen(ls_pathname, StreamMode!, Write!, LockWrite!, Replace!)
	FileWriteEx(li_fnum, lblob_data)
	FileClose(li_fnum)
	l_str_response.success = true
	l_str_response.result = ls_pathname // return download location, needed when as_download_location left blank
Else
	l_str_response.success = false
	l_str_response.message = "Error #" + String(ln_http.LastErrorNum) + ". " + ln_http.LastErrorText
	return l_str_response
End If

return l_str_response
end function

on u_service_file.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_service_file.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

