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

## Parte 2 — Primeros comandos

Ejecuta cada comando y pega la salida real:

```bash
$ echo "Mi primer experimento en Linux"
# Salida:

$ date
# Salida:

$ pwd
# Salida:

$ ls
# Salida:

$ echo $?
# Salida:    ¿Qué significa ese número?:
```

---

## Parte 3 — Pedir ayuda

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

## Parte 4 — Historial

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

## Parte 5 — Atajos de teclado

Marca los que ya probaste y describe qué hiciste:

- [ ] **Tab** → Escribe lo que completó: `ls /ho[Tab]` completó a: _______________
- [ ] **Ctrl+C** → ¿Qué proceso detuviste?: _______________
- [ ] **Ctrl+L** → ¿La pantalla se limpió? Sí / No
- [ ] **Ctrl+R** → ¿Qué buscaste y qué encontró?: _______________

---

## Parte 6 — Código de salida

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

## Parte 7 — Autoevaluación conceptual

Responde con tus propias palabras:

**¿Qué es el prompt y por qué es importante?**
>

**Explica la sintaxis de un comando con un ejemplo real que hayas ejecutado:**
>

**¿Cuándo usarías `man` vs `--help`?**
>

**¿Para qué sirve `$?` y cuándo lo usarías en bioinformática?**
>

---

## Parte 8 — Reflexión

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
- [ ] Sé usar `man`, `--help` y `whatis` para buscar ayuda
- [ ] Uso la flecha ↑ para navegar el historial
- [ ] Uso Ctrl+R para buscar en el historial
- [ ] Uso Tab para autocompletar (y lo hago automáticamente)
- [ ] Sé qué significa `echo $? = 0` y `echo $? = 127`

---

*Plantilla CEM-BIO-101 · M1 · Tema 1.2 · Nivel 0*
