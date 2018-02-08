$PBExportHeader$u_picture.sru
forward
global type u_picture from picture
end type
end forward

global type u_picture from picture
integer width = 2551
integer height = 1652
boolean originalsize = true
boolean focusrectangle = false
end type
global u_picture u_picture

forward prototypes
public subroutine of_set_picture_name (string as_picture_src)
end prototypes

public subroutine of_set_picture_name (string as_picture_src);/*
	of_set_picture_name - sets the image. Supports local and web http sources
*/
String 			ls_downloaded_file
str_response 	l_str_response
u_service_file l_u_service_file

if Pos(as_picture_src, "http://") > 0 OR Pos(as_picture_src, "https://") > 0 then
	// Assume web image, download to temp location and display
	l_u_service_file 	= 	create u_service_file
	l_str_response 	= 	l_u_service_file.of_download_file_from_url(as_picture_src, '')
	
	if l_str_response.success then
		this.picturename = l_str_response.result
	end if
else
	// Assume local image and set the property
	this.picturename = as_picture_src
end if


end subroutine

on u_picture.create
end on

on u_picture.destroy
end on

