# asm-arduino

### Configuracion de DOSBox
Abrir el DOSBox options y ubicar la sección [Serial]
Ubicar 
```
serial1=dummy
```
Sustituirlo por:
```
serial1=directserial realport:com1
```

El nombre del com1 depende del puerto que se va a enlazar con DOSBox

![image](https://user-images.githubusercontent.com/60149403/126088827-7a78e343-2aed-4003-ab87-ee52d27b0651.png)

### Configuracion de puertos virtuales:
Hay que usar un emulador de puertos:
Se agrega un par de puertos, depende los nombres con los que se generen, así se configura el DOSBox, el otro puerto se configura en proteus
* Yo configure: 
  * COM1 -> para DOSBox
  * COM2 -> proteus
 
![image](https://user-images.githubusercontent.com/60149403/126088960-a168ffdc-a265-4f00-956f-3968cbbf5b54.png)

### Comandos para probar en la consola de ensamblador
* led1e -> enciende el led 1
* led1a -> apaga el led 1
* led2e -> enciende el led 2
* led2a -> apaga el led 2
* d<numero> -> enciende el display con el numero indicado
 * Ejemplo: d8  enciende el numero 8 en el display

Presionar enter para enviar el comando.
