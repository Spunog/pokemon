$PBExportHeader$dao_pokemon.sru
forward
global type dao_pokemon from nonvisualobject
end type
end forward

global type dao_pokemon from nonvisualobject
end type
global dao_pokemon dao_pokemon

type variables
PRIVATE:
String i_s_base_url = 'https://pokeapi.co/api/v2/'
end variables

forward prototypes
public function any of_get_all ()
private function any of_get (str_args as_args[])
public function u_pokemon of_get_by_name (string as_name)
end prototypes

public function any of_get_all ();/*
	of_get_all - public method to return a list of pokemon
*/
u_pokemon 	l_u_pokemon_arr[]
str_args 	l_str_args[]

l_u_pokemon_arr = This.of_get(l_str_args)

return l_u_pokemon_arr
end function

private function any of_get (str_args as_args[]);/*
	PRIVATE: of_get 
*/

integer    		li_rc  
long       		ll_root, ll_count, ll_inc
string     		ls_string, ls_result
httpclient 		http  
JSONParser 		json  
long 				ll_pokemon_count
long 				ll_pokemon_list
long 				ll_pokemon_item
u_pokemon 		l_u_pokemon_arr[], l_u_pokemon
string			ls_request_url
long				ll_args_total
string			ls_result_type

// Function Vars
ls_request_url = i_s_base_url + 'pokemon/'
ls_result_type = 'list'

// Request URL
ll_args_total = upperbound(as_args)
if ll_args_total > 0 then
	for ll_inc = 1 to ll_args_total
		choose case as_args[ll_inc].field
			case 'name'
				ls_request_url += as_args[ll_inc].value + '/'
				ls_result_type = 'single'
		end choose
	next
end if

// Limit Results
ls_request_url += '?limit=20'

// Get Data Via RESTFul
if ls_result_type = 'single' then
	http 	= 	create httpclient  
	li_rc 	= 	http.sendrequest( 'GET', ls_request_url)  
	
	if li_rc = 1 and http.GetResponseStatusCode() = 200 then  
	  http.GetResponseBody(ls_string)  
	end if
else
	// Caching the full list results for testing
	ls_string 	= '{"count":949,"previous":null,"results":[{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/1\/","name":"bulbasaur"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/2\/","name":"ivysaur"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/3\/","name":"venusaur"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/4\/","name":"charmander"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/5\/","name":"charmeleon"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/6\/","name":"charizard"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/7\/","name":"squirtle"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/8\/","name":"wartortle"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/9\/","name":"blastoise"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/10\/","name":"caterpie"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/11\/","name":"metapod"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/12\/","name":"butterfree"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/13\/","name":"weedle"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/14\/","name":"kakuna"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/15\/","name":"beedrill"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/16\/","name":"pidgey"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/17\/","name":"pidgeotto"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/18\/","name":"pidgeot"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/19\/","name":"rattata"},{"url":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/20\/","name":"raticate"}],"next":"https:\/\/pokeapi.co\/api\/v2\/pokemon\/?limit=20&offset=20"}'
end if
	
// Parse Response
json 			= 	create JSONParser  
ls_result 	= 	json.loadstring( ls_string )  
ll_root 		= 	json.getrootitem()  
ll_count 	= 	json.getchildcount( ll_root )  

if ls_result_type = 'single' then
	// Single - this api returns a different json structure if request just one pokemon
	l_u_pokemon = create u_pokemon
	l_u_pokemon.of_set_name(json.GetItemString(ll_root, 'name'))
	l_u_pokemon.of_set_weight(json.GetItemnumber(ll_root, 'weight'))
	l_u_pokemon_arr[upperbound(l_u_pokemon_arr) + 1] = l_u_pokemon
else
	// List of Pokemon
	ll_pokemon_list	=	json.GetItemArray(ll_root, "results")
	ll_pokemon_count 	= 	json.getchildcount( ll_pokemon_list )  
	
	for ll_inc = 1 to ll_pokemon_count
		l_u_pokemon = create u_pokemon
		ll_pokemon_item = json.GetChildItem(ll_pokemon_list, ll_inc)
		l_u_pokemon.of_set_name(json.GetItemString(ll_pokemon_item, 'name'))
		l_u_pokemon.of_set_url(json.GetItemString(ll_pokemon_item, 'url'))
		l_u_pokemon_arr[upperbound(l_u_pokemon_arr) + 1] = l_u_pokemon
	next
end if

return l_u_pokemon_arr

end function

public function u_pokemon of_get_by_name (string as_name);/*
	of_get_by_name - 
*/

u_pokemon 	l_u_pokemon_arr[], l_u_pokemon
str_args 	l_str_args[], l_str_arg

// Build up arguments structure
l_str_arg.field = 'name'
l_str_arg.value = as_name
l_str_args[1] = l_str_arg

// Call common function to get matching result
l_u_pokemon_arr = this.of_get(l_str_args)

// If only one result then its most likely a valid match
if upperbound(l_u_pokemon_arr) = 1 then
	l_u_pokemon = l_u_pokemon_arr[1]
end if

return l_u_pokemon


end function

on dao_pokemon.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dao_pokemon.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

