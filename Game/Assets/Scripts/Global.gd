extends Node

#Script de uma cena glocal que funciona como um singleton.

#variável que possui a cena que está executando atualmente
var current_scene = null

#variável que guarda informação de música ou não entre cenas
var music_state

func _ready():
	#inicialmente, há música
	music_state = true
	#variável com a raiz da árvore do projeto
	var root = get_tree().get_root()
	#carrega a cena atual
	current_scene = root.get_child(root.get_child_count() - 1)


#função que troca a cena atual para uma nova especificada pelo caminho que é passado como argumento
func goto_scene(path):
    call_deferred("_deferred_goto_scene", path)


#função que troca de forma segura uma cena por outra
func _deferred_goto_scene(path):
    #Agora é seguro remover a cena atual
	current_scene.free()

    #Carrega a nova cena.
	var s = ResourceLoader.load(path)

    #Instancia a nova cena.
	current_scene = s.instance()
	
	get_tree().get_root().add_child(current_scene)
 
	get_tree().set_current_scene(current_scene)



#função para definir se a música está tocando ou não	
func set_music_state(state):
	music_state = state

#função para retornar o estado atual de música	
func get_music_state():
	return music_state

#função para encerrar a execução do jogo
func quit_game():
	get_tree().quit()
	
func reload_scene():
	get_tree().reload_current_scene()	