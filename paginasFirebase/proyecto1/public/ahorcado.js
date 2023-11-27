//No se olvide de respirar, mantenga la calma y demuestre lo que sabe
let palabraSecreta;
let intentos = 0;
let coincidencias = 0;
let errores = 0;
mostrarAhorcado = function () {
    if (errores == 1) {
        mostrarImagen("ahorcadoImagen", "Ahorcado_01.png");
    } else if (errores == 2) {
        mostrarImagen("ahorcadoImagen", "Ahorcado_02.png");
    } else if (errores == 3) {
        mostrarImagen("ahorcadoImagen", "Ahorcado_03.png");
    } else if (errores == 4) {
        mostrarImagen("ahorcadoImagen", "Ahorcado_04.png");
    } else if (errores == 5) {
        mostrarImagen("ahorcadoImagen", "Ahorcado_05.png");
    } else if (errores == 6) {
        mostrarImagen("ahorcadoImagen", "Ahorcado_06.png");
    } else if (errores == 7) {
        mostrarImagen("ahorcadoImagen", "Ahorcado_07.png");
    } else if (errores == 8) {
        mostrarImagen("ahorcadoImagen", "Ahorcado_08.png");
    } else if (errores == 9) {
        mostrarImagen("ahorcadoImagen", "Ahorcado_09.png");
    } else if (errores == 10) {
        mostrarImagen("ahorcadoImagen", "gameOver.gif");
    }

}
IngresarLetra = function () {
    let letraRecibida;
    letraRecibida = recuperarTexto("txtLetra");
    if (esMayuscula(letraRecibida) == true) {
        validar(letraRecibida);
    } else {
        alert("Solo se aceptan letras mayusculas");
    }
    if (coincidencias == 5) {
        mostrarImagen("ahorcadoImagen", "ganador.gif");
        alert("Ha Ganado");
    }
    if (intentos == 10) {
        alert("Ha Perdido");
    }
    intentos = intentos + 1;
}
validar = function (letra) {
    let letrasEncontradas = 0;
    let validacion = false;
    let letraInicial = letra.charCodeAt(letra);
    let codigo = palabraSecreta.length;
    let letraItinerada;
    for (let i = 0; i <= codigo; i++) {
        let posicion = i;
        letraItinerada = palabraSecreta.charCodeAt(i);
        if (letraInicial == letraItinerada) {
            letrasEncontradas = letrasEncontradas + 1;
            mostrarLetra(letra, posicion);
            validacion = true
        }
    }
    if (validacion == false) {
        errores = errores + 1;
        mostrarAhorcado();
    }
    coincidencias = coincidencias + letrasEncontradas;
}
mostrarLetra = function (letra, posicion) {
    let cadena = palabraSecreta.length;
    for (let i = 0; i <= cadena; i++) {
        if (i == posicion) {
            mostrarTexto("div" + posicion, letra);
        }
    }
}
guardarPalabra = function () {
    let palabra = recuperarTexto("txtSecreta");
    let palabraItinerada = palabra.length;
    if (palabraItinerada == 5) {
        if (esMayuscula(palabra) == true) {
            palabraSecreta = palabra
        } else {
            alert("Solo se aceptan letras 5 mayusculas");
        }
    }

}
esMayuscula = function (caracter) {
    let cadena = caracter.length - 1;
    let codigo;
    for (let i = 0; i <= cadena; i++) {
        codigo = caracter.charCodeAt(i);
        if (codigo >= 65 && codigo <= 90) {
            return true;
        }
    }
}