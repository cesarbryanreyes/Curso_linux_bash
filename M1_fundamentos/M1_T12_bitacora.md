# Bitácora M1 · Tema 1.2 — La Terminal, Shell y Bash

**Nombre:** <!-- escribe tu nombre aquí -->  
**Fecha:** <!-- dd/mm/yyyy -->  
**Sistema operativo:** <!-- Windows + WSL2 / macOS / Linux nativo -->

---

## Parte 1 — El prompt

Abre tu terminal y copia exactamente el prompt que ves:

```
Mi prompt es:

```

Identifica cada parte:
- Mi nombre de usuario: _______________
- Nombre de mi computadora/máquina: _______________
- Directorio actual que muestra: _______________
- Símbolo al final ($ o #): _______________
- ¿Qué significa ese símbolo?: _______________

---

## Parte 2 — Sintaxis de un comando

```bash
$ ls -lh /home
# Identifica: comando ___ · opción ___ · argumento ___
```

Escribe un ejemplo de comando mal escrito por falta de espacio, y cómo se corrige:
>

---

## Parte 3 — Tab y Ctrl+C (antes de escribir nada más)

Prueba Tab:
```bash
$ ls /ho[Tab]
# ¿A qué se completó?:

$ ls ~/Do[Tab][Tab]
# ¿Qué opciones te mostró?:
```

- [ ] **Tab** → Escribe lo que completó: `ls /ho[Tab]` completó a: _______________

Prueba Ctrl+C:
```bash
$ echo "texto sin cerrar
# ¿A qué símbolo cambió el prompt?:

# Presiona Ctrl+C
# ¿Volviste al prompt normal $? Sí / No
```

- [ ] **Ctrl+C** → ¿Qué situación probaste: detener un proceso, o escapar de un prompt extraño?: _______________

---

## Parte 4 — Primeros comandos

Ejecuta cada comando y pega la salida real:

```bash
$ echo "Mi primer experimento en Linux"
# Salida:

$ date
# Salida:

$ cal
# Salida:

$ pwd
# Salida:

$ ls
# Salida:

$ echo $?
# Salida:    ¿Qué significa ese número?:

$ clear
# ¿La pantalla se limpió? Sí / No
```

---

## Parte 5 — Historial

```bash
$ history | tail -10
# Pega las últimas 10 líneas de tu historial:

```

Prueba Ctrl+R:
- ¿Qué parte del comando escribiste para buscarlo?: _______________
- ¿Qué comando encontró?: _______________

Prueba `!!`:
```bash
$ echo "prueba historial"
# Salida:

$ !!
# ¿Qué ejecutó y cuál fue la salida?:
```

---

## Parte 6 — Pedir ayuda

```bash
$ man ls
# Sin copiar el manual completo, escribe UNA cosa que aprendiste que no sabías:
→

$ ls --help
# ¿Cuál es la opción para ordenar por fecha de modificación?:
→

$ whatis grep
# Salida:
```

---

## Parte 7 — Resto de atajos de teclado

Marca los que ya probaste y describe qué hiciste:

- [ ] **Ctrl+L** → ¿La pantalla se limpió? Sí / No
- [ ] **Ctrl+D** → ¿Qué pasó al usarlo?: _______________
- [ ] **Ctrl+A / Ctrl+E** → ¿A dónde saltó el cursor en cada caso?: _______________
- [ ] **Ctrl+Z** → ¿Qué proceso pausaste? ¿Usaste fg o bg para recuperarlo?: _______________

---

## Parte 8 — Código de salida

```bash
# Comando exitoso:
$ whoami
# Salida:

$ echo $?
# Código:    ¿Qué significa?:

# Comando con error:
$ ls directorio_que_no_existe
# Salida:

$ echo $?
# Código:    ¿Qué significa según la tabla?:
```

---

## Parte 9 — Autoevaluación conceptual

Responde con tus propias palabras:

**¿Qué es el prompt y por qué es importante?**
>

**Explica la sintaxis de un comando con un ejemplo real que hayas ejecutado:**
>

**¿Por qué Tab y Ctrl+C se aprenden antes que cualquier otro comando?**
>

**¿Cuándo usarías `man` vs `--help`?**
>

**¿Para qué sirve `$?` y cuándo lo usarías en bioinformática?**
>

---

## Parte 10 — Reflexión

| Pregunta | Tu respuesta |
|---|---|
| ¿Qué atajo te pareció más útil? | |
| ¿Qué fue lo más difícil de este tema? | |
| ¿Qué comando o concepto quieres explorar más? | |
| ¿Qué pregunta te quedó pendiente? | |

---

## Checklist de logros

- [ ] Puedo leer e identificar todas las partes del prompt
- [ ] Entiendo la diferencia entre $ (usuario normal) y # (root)
- [ ] Escribo comandos con la sintaxis correcta (espacio entre partes)
- [ ] Uso Tab para autocompletar (y lo hago automáticamente)
- [ ] Uso Ctrl+C para detener procesos o escapar de un prompt extraño
- [ ] Ejecuté mis primeros comandos: echo, date, cal, pwd, ls, echo $?, clear
- [ ] Uso la flecha ↑ para navegar el historial
- [ ] Uso Ctrl+R para buscar en el historial
- [ ] Sé usar `man`, `--help` y `whatis` para buscar ayuda
- [ ] Conozco el resto de atajos: Ctrl+L, Ctrl+D, Ctrl+A/E, Ctrl+Z
- [ ] Sé qué significa `echo $? = 0` y `echo $? = 127`

---

*Plantilla CEM-BIO-101 · M1 · Tema 1.2 · Nivel 0*
