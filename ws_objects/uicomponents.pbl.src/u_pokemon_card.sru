$PBExportHeader$u_pokemon_card.sru
forward
global type u_pokemon_card from userobject
end type
type st_weight from statictext within u_pokemon_card
end type
type lbl_weight from statictext within u_pokemon_card
end type
type lbl_name from statictext within u_pokemon_card
end type
type st_name from statictext within u_pokemon_card
end type
type p_loader from picture within u_pokemon_card
end type
type p_bg_pokedex from picture within u_pokemon_card
end type
type p_profile_pic from u_picture within u_pokemon_card
end type
end forward

global type u_pokemon_card from userobject
integer width = 2921
integer height = 1916
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_weight st_weight
lbl_weight lbl_weight
lbl_name lbl_name
st_name st_name
p_loader p_loader
p_bg_pokedex p_bg_pokedex
p_profile_pic p_profile_pic
end type
global u_pokemon_card u_pokemon_card

type variables
PRIVATE:
u_pokemon 	i_u_pokemon
long			i_l_label_colour = RGB(217,175,7)
long			i_l_field_colour = RGB(58,92,167)
end variables

forward prototypes
public subroutine of_set_pokemon (u_pokemon a_u_pokemon)
public subroutine of_resize (long al_width, long al_height)
public subroutine of_toggle_loading (boolean ab_show_loader)
end prototypes

public subroutine of_set_pokemon (u_pokemon a_u_pokemon);// Record instance
this.i_u_pokemon = a_u_pokemon

// Update Object
this.st_name.text 	= 	this.i_u_pokemon.of_get_name()
this.st_weight.text 	= 	String(this.i_u_pokemon.of_get_weight())

// Set Avatar
this.p_profile_pic.of_set_picture_name(this.i_u_pokemon.of_get_sprite_front())

end subroutine

public subroutine of_resize (long al_width, long al_height);// Center Loading Image
p_loader.x = (al_width / 2)  - (p_loader.width/2)
p_loader.y = (al_height / 2) - (p_loader.height/2)
end subroutine

public subroutine of_toggle_loading (boolean ab_show_loader);this.p_loader.visible = ab_show_loader
end subroutine

on u_pokemon_card.create
this.st_weight=create st_weight
this.lbl_weight=create lbl_weight
this.lbl_name=create lbl_name
this.st_name=create st_name
this.p_loader=create p_loader
this.p_bg_pokedex=create p_bg_pokedex
this.p_profile_pic=create p_profile_pic
this.Control[]={this.st_weight,&
this.lbl_weight,&
this.lbl_name,&
this.st_name,&
this.p_loader,&
this.p_bg_pokedex,&
this.p_profile_pic}
end on

on u_pokemon_card.destroy
destroy(this.st_weight)
destroy(this.lbl_weight)
destroy(this.lbl_name)
destroy(this.st_name)
destroy(this.p_loader)
destroy(this.p_bg_pokedex)
destroy(this.p_profile_pic)
end on

event constructor;// Set Colours

// Colour: Name
This.lbl_name.textcolor		= This.i_l_label_colour
This.st_name.textcolor 		= This.i_l_field_colour

// Colour: Weight
This.lbl_weight.textcolor	= This.i_l_label_colour
This.st_weight.textcolor 	= This.i_l_field_colour

end event

type st_weight from statictext within u_pokemon_card
integer x = 1728
integer y = 1284
integer width = 955
integer height = 136
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 553648127
boolean focusrectangle = false
end type

type lbl_weight from statictext within u_pokemon_card
integer x = 1728
integer y = 1120
integer width = 457
integer height = 136
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 553648127
string text = "Weight:"
boolean focusrectangle = false
end type

type lbl_name from statictext within u_pokemon_card
integer x = 1728
integer y = 584
integer width = 379
integer height = 132
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 553648127
string text = "Name:"
boolean focusrectangle = false
end type

type st_name from statictext within u_pokemon_card
integer x = 1728
integer y = 732
integer width = 955
integer height = 136
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 553648127
boolean focusrectangle = false
end type

type p_loader from picture within u_pokemon_card
boolean visible = false
integer x = 96
integer y = 72
integer width = 219
integer height = 192
boolean bringtotop = true
boolean originalsize = true
string picturename = "images\icons\ic_schedule_black_24dp\web\ic_schedule_black_24dp_2x.png"
boolean focusrectangle = false
end type

type p_bg_pokedex from picture within u_pokemon_card
integer width = 2921
integer height = 1916
boolean originalsize = true
string picturename = "images\background\bg_pokedex.png"
boolean focusrectangle = false
end type

type p_profile_pic from u_picture within u_pokemon_card
integer x = 128
integer y = 504
integer width = 1166
integer height = 916
boolean bringtotop = true
boolean originalsize = false
end type

