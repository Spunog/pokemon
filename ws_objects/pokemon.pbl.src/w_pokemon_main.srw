$PBExportHeader$w_pokemon_main.srw
$PBExportComments$Generated SDI Main Window
forward
global type w_pokemon_main from window
end type
type p_clear from picture within w_pokemon_main
end type
type p_search from picture within w_pokemon_main
end type
type sle_search from singlelineedit within w_pokemon_main
end type
type p_header from picture within w_pokemon_main
end type
type p_logo from picture within w_pokemon_main
end type
type p_2 from picture within w_pokemon_main
end type
type dw_pokemon_list from datawindow within w_pokemon_main
end type
type uo_profile_card from u_pokemon_card within w_pokemon_main
end type
end forward

global type w_pokemon_main from window
integer width = 5801
integer height = 2792
boolean titlebar = true
string title = "Pokédex"
boolean controlmenu = true
long backcolor = 16777215
boolean center = true
p_clear p_clear
p_search p_search
sle_search sle_search
p_header p_header
p_logo p_logo
p_2 p_2
dw_pokemon_list dw_pokemon_list
uo_profile_card uo_profile_card
end type
global w_pokemon_main w_pokemon_main

type variables
PRIVATE:
dao_pokemon i_dao_pokemon
u_pokemon 	i_u_pokemon_arr[]
end variables

on w_pokemon_main.create
this.p_clear=create p_clear
this.p_search=create p_search
this.sle_search=create sle_search
this.p_header=create p_header
this.p_logo=create p_logo
this.p_2=create p_2
this.dw_pokemon_list=create dw_pokemon_list
this.uo_profile_card=create uo_profile_card
this.Control[]={this.p_clear,&
this.p_search,&
this.sle_search,&
this.p_header,&
this.p_logo,&
this.p_2,&
this.dw_pokemon_list,&
this.uo_profile_card}
end on

on w_pokemon_main.destroy
destroy(this.p_clear)
destroy(this.p_search)
destroy(this.sle_search)
destroy(this.p_header)
destroy(this.p_logo)
destroy(this.p_2)
destroy(this.dw_pokemon_list)
destroy(this.uo_profile_card)
end on

event open;Long ll_inc

// Create DAO Instance
This.i_dao_pokemon 	= create dao_pokemon

// Fill Pokemon Array
This.i_u_pokemon_arr = This.i_dao_pokemon.of_get_all()

// Fill Datawindow
for ll_inc = 1 to upperbound(This.i_u_pokemon_arr)
	this.dw_pokemon_list.insertrow(0)
	this.dw_pokemon_list.setitem(ll_inc, 'name', This.i_u_pokemon_arr[ll_inc].of_get_name())
	this.dw_pokemon_list.setitem(ll_inc, 'url', This.i_u_pokemon_arr[ll_inc].of_get_url())
	this.dw_pokemon_list.setitem(ll_inc, 'position', ll_inc)
next

this.dw_pokemon_list.setsort('name')
this.dw_pokemon_list.sort()

// Set focus to search
this.sle_search.setfocus()
end event

event resize;Long ll_margin

ll_margin = 40

// Title
This.p_logo.X 						= 	ll_margin

// Header BG
This.p_header.X					=	newwidth - This.p_header.width - ll_margin

// List DW
This.dw_pokemon_list.X			=	This.p_logo.X
This.dw_pokemon_list.width 	= 	This.p_logo.width
This.dw_pokemon_list.height 	= 	newheight - This.dw_pokemon_list.Y - ll_margin

// Profile Card
This.uo_profile_card.resize(This.uo_profile_card.width, This.uo_profile_card.height)
end event

type p_clear from picture within w_pokemon_main
integer x = 2107
integer y = 772
integer width = 219
integer height = 192
boolean originalsize = true
string picturename = "images\icons\ic_clear_black_24dp\web\ic_clear_black_24dp_2x.png"
boolean focusrectangle = false
end type

event clicked;sle_search.text = ''
dw_pokemon_list.setfilter('')
dw_pokemon_list.filter()
end event

type p_search from picture within w_pokemon_main
integer x = 1870
integer y = 772
integer width = 219
integer height = 192
boolean originalsize = true
string picturename = "images\icons\ic_search_black_24dp\web\ic_search_black_24dp_2x.png"
boolean focusrectangle = false
end type

type sle_search from singlelineedit within w_pokemon_main
integer x = 37
integer y = 772
integer width = 1810
integer height = 184
integer taborder = 30
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;if this.text = '' then
	dw_pokemon_list.setfilter('')
else
	dw_pokemon_list.setfilter('name like "%' + this.text + '%"')	
end if

dw_pokemon_list.filter()
end event

type p_header from picture within w_pokemon_main
integer x = 4069
integer width = 1687
integer height = 736
boolean originalsize = true
string picturename = "images\background\bg_header.png"
boolean focusrectangle = false
end type

type p_logo from picture within w_pokemon_main
integer width = 2286
integer height = 736
boolean originalsize = true
string picturename = "images\background\pokemon_logo.png"
boolean focusrectangle = false
end type

type p_2 from picture within w_pokemon_main
integer y = 4820
integer width = 8777
integer height = 4800
boolean originalsize = true
string picturename = "C:\Users\SILVERSTONE\Development\Powerbuilder\Pokemon\images\background\bg_main.png"
boolean focusrectangle = false
end type

type dw_pokemon_list from datawindow within w_pokemon_main
integer y = 1004
integer width = 2327
integer height = 1488
integer taborder = 10
string title = "none"
string dataobject = "d_pokemon_list"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;Long 			ll_position
string		ls_pokemon_name
u_pokemon	l_u_pokemon

// Highlight row
this.selectrow(0,false)
this.selectrow(row,true)

// Update Profile Card
ls_pokemon_name 	= 	this.getitemstring(row, 'name')
ll_position 		= 	this.getitemnumber(row, 'position')

// Call DAO to get detailed information about selected pokemon
this.enabled = false
parent.uo_profile_card.of_toggle_loading(true)
l_u_pokemon = parent.i_dao_pokemon.of_get_by_name(ls_pokemon_name)
parent.uo_profile_card.of_set_pokemon(l_u_pokemon) //i_u_pokemon_arr[ll_position]
parent.uo_profile_card.of_toggle_loading(false)
this.enabled = true
end event

type uo_profile_card from u_pokemon_card within w_pokemon_main
integer x = 2638
integer y = 772
integer width = 3077
integer taborder = 20
boolean bringtotop = true
end type

on uo_profile_card.destroy
call u_pokemon_card::destroy
end on

