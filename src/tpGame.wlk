import wollok.game.*

object manchaMania {
	const personajes = [ amongUsRojo1, amongUsVerde1, amongUsCeleste1, amongUsArcoIris1, amongUsRojo2, amongUsVerde2, amongUsCeleste2, amongUsArcoIris2 ]
	const property jugadores = [ jugador1, jugador2 ]
	const property opciones = [ menuJugar, menuReglas, menuCreadores ]

	method menu() {
		game.title("Mancha Mania")
		game.boardGround("fondo.jpg")
		game.height(13)
		game.width(18)
		game.addVisual(bot)
		opciones.forEach({ o => game.addVisual(o)})
		game.say(bot, "Seleccione una Opcion, presione DEL para volver")
		opciones.forEach({ o => game.showAttributes(o)})
		game.showAttributes(bot)
		keyboard.space().onPressDo({ self.elegirPersonajes()})
		keyboard.enter().onPressDo({ self.mostrarReglas()})
		keyboard.shift().onPressDo({ self.mostrarCreadores()})
	}

	method elegirPersonajes() {
		game.addVisual(aspectos)
		game.say(bot, "Elijan sus aspectos")
		personajes.forEach({ p => game.addVisual(p)})
		personajes.forEach({ p => game.showAttributes(p)})
		keyboard.num1().onPressDo({ jugador1.imagenJugador(amongUsRojo1)})
		keyboard.num2().onPressDo({ jugador1.imagenJugador(amongUsVerde1)})
		keyboard.num3().onPressDo({ jugador1.imagenJugador(amongUsCeleste1)})
		keyboard.num4().onPressDo({ jugador1.imagenJugador(amongUsArcoIris1)})
		keyboard.num5().onPressDo({ jugador2.imagenJugador(amongUsRojo2)})
		keyboard.num6().onPressDo({ jugador2.imagenJugador(amongUsVerde2)})
		keyboard.num7().onPressDo({ jugador2.imagenJugador(amongUsCeleste2)})
		keyboard.num8().onPressDo({ jugador2.imagenJugador(amongUsArcoIris2)})
		keyboard.alt().onPressDo({ self.elegirMapa()})
		keyboard.del().onPressDo({game.removeVisual(aspectos)})
		keyboard.del().onPressDo({personajes.forEach({p=>game.removeVisual(p)})})
	}

	method jugar() {
		game.onCollideDo(jugador1,{algo => algo.afectar(jugador1)})
		game.onCollideDo(jugador2,{algo => algo.afectar(jugador2)})
		
		
		keyboard.up().onPressDo({ jugador1.aArriba()})
		keyboard.down().onPressDo({ jugador1.aAbajo()})
		keyboard.right().onPressDo({ jugador1.aLaDerecha()})
		keyboard.left().onPressDo({ jugador1.aLaIzquierda()})
		keyboard.w().onPressDo({ jugador2.aArriba()})
		keyboard.s().onPressDo({ jugador2.aAbajo()})
		keyboard.d().onPressDo({ jugador2.aLaDerecha()})
		keyboard.a().onPressDo({ jugador2.aLaIzquierda()})

	}
	
	method elegirMapa(){
		game.say(bot, "Elijan un mapa")
		opciones.forEach({ o => game.removeVisual(o)})
		game.removeVisual(aspectos)
		personajes.forEach({ p => game.removeVisual(p)}) // para evitar interacciones, sacamos todo lo que no se utiliza mas
		
		game.addVisual(mapaChiquito1)
		game.addVisual(mapaChiquito2)
		game.addVisual(mapaChiquito3)
		game.showAttributes(mapaChiquito1)
		game.showAttributes(mapaChiquito2)
		game.showAttributes(mapaChiquito3)
		
		keyboard.j().onPressDo({self.mapa(mapa1)})
		keyboard.k().onPressDo({self.mapa(mapa2)})
		keyboard.l().onPressDo({self.mapa(mapa3)})
	}
	
	method mapa(mapaX){
		game.removeVisual(bot)
		game.removeVisual(mapaChiquito1)
		game.removeVisual(mapaChiquito2)
		game.removeVisual(mapaChiquito3)
		
		game.addVisual(mapaX)
		mapaX.interacciones()
		game.addVisual(jugador1)
		game.addVisual(jugador2)
		self.jugar()
	}
	
	method agregarInteraccion(agujeros,saltosDoble,portales,vidasExtra){
		game.schedule(5000,{=>agujeros.forEach({ a => game.addVisual(a)})})
		game.schedule(10000,{=>portales.forEach({ p => game.addVisual(p)})})
		game.schedule(15000,{=>saltosDoble.forEach({ d => game.addVisual(d)})})
		game.schedule(20000,{=>vidasExtra.forEach({v => game.addVisual(v)})})
	}
	
	method fin() {
		game.addVisual(finalizarJuego)
		game.showAttributes(finalizarJuego)
		keyboard.control().onPressDo({ game.stop()})
	}

	method mostrarReglas() {
		game.addVisual(infoReglas)
		keyboard.del().onPressDo({ game.removeVisual(infoReglas)})
	}

	method mostrarCreadores() {
		game.addVisual(infoCreadores)
		keyboard.del().onPressDo({ game.removeVisual(infoCreadores)})
	}

	method quitarDeLista(personaje) {
		personajes.remove(personaje)
	}

}

class MapaChiquito{
	
	const property position 
	const property image 
	const property presione
	
}

const mapaChiquito1 = new MapaChiquito(position = game.at(2,5),image = "mapaChiquito1.jpg",presione = "Tecla j")
const mapaChiquito2 = new MapaChiquito(position = game.at(7,5),image = "mapaChiquito2.jpg",presione = "Tecla k")
const mapaChiquito3 = new MapaChiquito(position = game.at(12,5),image = "mapaChiquito3.jpg",presione = "Tecla l")


class Mapa{
	const property position
	const property image
	const property agujeros
	const property saltosDobles
	const property portales
	const property vidasExtra

	method afectar(jugador){ //para evitar un mensaje de error
		
	}
	
	method interacciones(){
		manchaMania.agregarInteraccion(agujeros,saltosDobles,portales,vidasExtra)
	}
}

const mapa1 = new Mapa(position = game.origin(),image = "mapa1.jpg",agujeros =[agujero1,agujero2,agujero4,agujero8,agujero6],saltosDobles = [saltoDoble1,saltoDoble3],portales = [portal1,destino1,portal2,destino2],vidasExtra = [vidaExtra1,vidaExtra3])
const mapa2 = new Mapa(position = game.origin(),image = "mapa2.jpg",agujeros =[agujero1,agujero4,agujero3,agujero7],saltosDobles = [saltoDoble2,saltoDoble5],portales = [portal2,destino2,portal4,destino4],vidasExtra = [vidaExtra2])
const mapa3 = new Mapa(position = game.origin(),image = "mapa3.jpg",agujeros =[agujero3,agujero5,agujero6,agujero8,agujero2],saltosDobles = [saltoDoble1,saltoDoble2,saltoDoble4],portales = [portal1,portal3,destino1,destino3],vidasExtra = [vidaExtra3])


object fondo {

	const property position = game.origin()
	const property image = "fondo.jpg"

}

object aspectos {

	const property position = game.origin()
	const property image = "aspectos.png"

}

object bot {

	const property position = game.at(1, 12)
	const property image = "bot.png"

}

class Boton {

	const property presione
	const property position
	const property image

}

const menuJugar = new Boton(presione = "Tecla Space", position = game.at(4, 8), image = "jugar.jpg")

const menuReglas = new Boton(presione = "Tecla Enter", position = game.at(4, 5), image = "reglas.jpg")

const menuCreadores = new Boton(presione = "Tecla Shift", position = game.at(4, 2), image = "creadores.jpg")

const finalizarJuego = new Boton(presione = "Tecla control", position = game.at(5, 5), image = "finalizarJuego.png")

class Informacion {

	const property position
	const property image

}

const infoReglas = new Informacion(position = game.at(-1, 0), image = "infoReglas.jpg")

const infoCreadores = new Informacion(position = game.origin(), image = "infoCreadores.jpg")

class Agujeros {

	const property position
	const property image
	
	method afectar(jugador){
		jugador.caerse()
	}

}

const agujero1 = new Agujeros(position = game.at(4, 3), image = "agujero.png")

const agujero2 = new Agujeros(position = game.at(7, 9), image = "agujero.png")

const agujero3 = new Agujeros(position = game.at(2, 8), image = "agujero.png")

const agujero4 = new Agujeros(position = game.at(8, 1), image = "agujero.png")

const agujero5 = new Agujeros(position = game.at(5, 5), image = "agujero.png")

const agujero6 = new Agujeros(position = game.at(10, 7), image = "agujero.png")
const agujero7 = new Agujeros(position = game.at(11, 9), image = "agujero.png")
const agujero8 = new Agujeros(position = game.at(2, 4), image = "agujero.png")

class Jugador {

	var property vida
	var property position
	var property image = ""
	var property turno
	const property otroJugador
	var property salto
	const respawn

	method imagenJugador(personaje) {
		image = personaje.image()
		game.removeVisual(personaje)
		manchaMania.quitarDeLista(personaje) // para evitar que colisione con otros obejtos
	}

	method aArriba() {
		if (turno > 0 && self.position().y()<12) {
			position = position.up(1)
			turno = turno - 1
			otroJugador.sumarTurno()
		}
		else{
			game.say(self,"No puedo moverme :(") //ya sea porque no es su turno o porque se estaria yendo del mapa
		}
	}

	method aLaDerecha() {
		if (turno > 0 && self.position().x()<16) {
			position = position.right(1)
			turno = turno - 1
			otroJugador.sumarTurno()
		}
		else{
			game.say(self,"No puedo moverme :(")
		}
	}

	method aLaIzquierda() {
		if (turno > 0 && self.position().x()>0) {
			position = position.left(1)
			turno = turno - 1
			otroJugador.sumarTurno()
		}
		else{
			game.say(self,"No puedo moverme :(")
		}
	}

	method aAbajo() {
		if (turno > 0 && self.position().y()>0) {
			position = position.down(1)
			turno = turno - 1
			otroJugador.sumarTurno()
		}
		else{
			game.say(self,"No puedo moverme :(")
		}
	}

	method sumarTurno() {
		if (otroJugador.turno() == 0) {
			turno += salto
		}
	}

	method dobleTurno() {
		salto *= 2 // por alguna razon se mueve 4 veces en lugar de 2
	}

	method perder(premio) {
		game.removeVisual(self)
		otroJugador.ganar(premio)
		game.schedule(5000, {=> manchaMania.fin()})
	}

	method ganar(premio) {
		game.addVisualCharacterIn(premio, self.position())
	}

	method moverseA(destino) {
		position = destino.position()
	}

	method caerse() {
		if (vida == 1) {
			self.perder(copa)
		} else {
			self.moverseA(respawn)
			vida -= 1
		}
	}

	method sumarseVida() {
		vida += 1
	}

}

object jugador1 inherits Jugador(vida = 1, position = game.origin(), turno = 1, otroJugador = jugador2, salto = 1, respawn = respawnJ1) {

	


	method afectar(jugador){
		jugador.perder(cadaver)
	}


}

object jugador2 inherits Jugador(vida = 1, position = game.at(14, 11), turno = 0, otroJugador = jugador1, salto = 1, respawn = respawnJ2) {


	var property movimientos = 0 // de esta manera sabemos cuantas veces se movio
	
	method afectar(jugador) {
		
	}

	override method sumarTurno() {
		super()
		movimientos += 1
		if (movimientos == 50) {
			self.sobrevivir()
			game.say(self, "AL FIN 50 MOVIMIENTOS!")
		}
	}

	method sobrevivir() {
		otroJugador.perder(copa)
	}

}

object cadaver {

	const property image = "cadaver.png" // estaria bueno que cada color tenga su cadaver, pero no encontre imagenes png de todos
	
	method afectar(jugador){ //de esta manera cuando aparece al final, no salta el mensaje de error
		
	}
}

object copa {

	const property image = "trofeo.png"
	
	method afectar(jugador){//de esta manera cuando aparece al final, no salta el mensaje de error
		
	}

}

class Personaje {

	const property tecla
	const property position
	const property image

}

const amongUsRojo1 = new Personaje(tecla = 1, position = game.at(5, 7), image = "amongUsRojo.png")

const amongUsVerde1 = new Personaje(tecla = 2, position = game.at(7, 7), image = "amongUsVerde.png")

const amongUsCeleste1 = new Personaje(tecla = 3, position = game.at(9, 7), image = "amongUsCeleste.png")

const amongUsArcoIris1 = new Personaje(tecla = 4, position = game.at(11, 7), image = "amongUsArcoIris.png")

const amongUsRojo2 = new Personaje(tecla = 5, position = game.at(5, 4), image = "amongUsRojo.png")

const amongUsVerde2 = new Personaje(tecla = 6, position = game.at(7, 4), image = "amongUsVerde.png")

const amongUsCeleste2 = new Personaje(tecla = 7, position = game.at(9, 4), image = "amongUsCeleste.png")

const amongUsArcoIris2 = new Personaje(tecla = 8, position = game.at(11, 4), image = "amongUsArcoIris.png")

class SaltoDoble {

	const property position
	const property image

	method afectar(jugador) {
		jugador.dobleTurno()
		game.say(jugador,"Doble Salto")
		game.removeVisual(self)
	}

}

const saltoDoble1 = new SaltoDoble(position = game.at(10, 4), image = "saltoDoble.png")

const saltoDoble2 = new SaltoDoble(position = game.at(5, 8), image = "saltoDoble.png")
const saltoDoble3 = new SaltoDoble(position = game.at(2, 9), image = "saltoDoble.png")
const saltoDoble4 = new SaltoDoble(position = game.at(3, 6), image = "saltoDoble.png")
const saltoDoble5 = new SaltoDoble(position = game.at(7, 9), image = "saltoDoble.png")


class Portal {

	const property position
	const property image
	const property destino

	method afectar(jugador) {
		jugador.moverseA(destino)
	}

}

const portal1 = new Portal(position = game.at(1, 3), image = "portal.png", destino = destino1)

const portal2 = new Portal(position = game.at(9, 8), image = "portal.png", destino = destino2)
const portal3 = new Portal(position = game.at(4, 12), image = "portal.png", destino = destino3)
const portal4 = new Portal(position = game.at(8,2), image = "portal.png", destino = destino4)

class Destino {

	const property position
	const property image
	
	method afectar(jugador){ //para evitar que salte un mensaje al pasar por encima consultar si esta bien dejarlo asi
	game.say(self,"Yo soy la salida")
	}

}

const destino1 = new Destino(position = game.at(7, 12), image = "destino.png")

const destino2 = new Destino(position = game.at(4, 8), image = "destino.png")

const destino3 = new Destino(position = game.at(10, 2), image = "destino.png")

const destino4 = new Destino(position = game.at(2, 9), image = "destino.png")
class VidaExtra {

	const property position
	const property image

	method afectar(jugador) {
		jugador.sumarseVida()
		game.say(jugador,"Vida Extra")
		game.removeVisual(self)
	}

}

const vidaExtra1 = new VidaExtra(position = game.at(9, 7), image = "corazon.png")
const vidaExtra2 = new VidaExtra(position = game.at(8, 4), image = "corazon.png")
const vidaExtra3 = new VidaExtra(position = game.at(3,11), image = "corazon.png")

class Respawn {

	const property position = game.at(1, 11)

}

const respawnJ1 = new Respawn(position = game.origin())

const respawnJ2 = new Respawn(position = game.at(14, 11))



//otro obstaculo podrian ser unas paredes/vayas que no te permitan moverte hacia donde estan, misma logica que los limites del mapa
