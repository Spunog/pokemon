$PBExportHeader$u_pokemon.sru
forward
global type u_pokemon from nonvisualobject
end type
end forward

global type u_pokemon from nonvisualobject
end type
global u_pokemon u_pokemon

type variables
PRIVATE:
string 	i_s_name
string	i_s_url
long		i_l_weight
end variables
forward prototypes
public subroutine of_set_name (string as_name)
public subroutine of_set_url (string as_url)
public function string of_get_url ()
public function string of_get_name ()
public function long of_get_weight ()
public subroutine of_set_weight (long al_weight)
end prototypes

public subroutine of_set_name (string as_name);this.i_s_name = as_name
end subroutine

public subroutine of_set_url (string as_url);this.i_s_url = as_url
end subroutine

public function string of_get_url ();return this.i_s_url
end function

public function string of_get_name ();return this.i_s_name
end function

public function long of_get_weight ();return this.i_l_weight
end function

public subroutine of_set_weight (long al_weight);this.i_l_weight = al_weight
end subroutine

on u_pokemon.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_pokemon.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

