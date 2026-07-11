# Bitácora M1 · Tema 1.5 — Permisos de Ejecución para tus Propios Scripts

**Nombre:** <!-- escribe tu nombre aquí -->
**Fecha:** <!-- dd/mm/yyyy -->
**Sistema operativo:** <!-- Windows + WSL2 / macOS / Linux nativo -->

---

## Parte 1 — Crear el script: touch, nano y cat

```bash
$ touch scripts/saludo.sh
$ ls -l scripts/saludo.sh
# Mi salida (archivo vacío):

```

```bash
$ nano scripts/saludo.sh
# Escribe dentro de nano:
#   #!/bin/bash
#   echo "Hola, soy tu primer script"
# Guarda con Ctrl+O, Enter, y sal con Ctrl+X
```

```bash
$ cat scripts/saludo.sh
# Mi salida:

```

¿Coincide exactamente con lo que escribiste en nano? Sí / No

---

## Parte 2 — El problema

```bash
$ ./scripts/saludo.sh
# Mi salida (probablemente un error):

```

¿Qué mensaje de error obtuviste? Escríbelo exactamente como apareció:
>

---

## Parte 3 — Diagnosticar con ls -l

```bash
$ ls -l scripts/saludo.sh
# Mi salida:

```

Descompón la cadena de permisos que obtuviste en sus 4 partes (tipo / Propietario / Grupo / Otros):
>

¿Cuál de las tres posiciones (Propietario, Grupo, Otros) le faltaba la x?
>

---

## Parte 4 — chmod +x

```bash
$ chmod +x scripts/saludo.sh
$ ls -l scripts/saludo.sh
# Mi salida después de chmod:

```

¿Cambió la cadena de permisos? Descríbela:
>

---

## Parte 5 — chmod 755 (forma numérica)

Sin ejecutar el comando todavía, calcula tú mismo:

¿A qué número equivale rwx? _______  ¿Y r-x? _______

```bash
$ chmod 755 scripts/saludo.sh
# ¿El resultado coincide con lo que calculaste?

```

---

## Parte 6 — Ejecutar con ./

```bash
$ ./scripts/saludo.sh
# Mi salida:

```

¿Por qué no puedes ejecutar el script escribiendo solo `saludo.sh` (sin el `./`)? Explica con tus propias palabras, relacionándolo con $PATH del Tema 1.1:
>

---

## Parte 7 — Autoevaluación conceptual

**¿Qué diferencia hay entre crear un archivo (Tema 1.4) y darle permiso de ejecución (Tema 1.5)?**
>

**¿Por qué chmod +x y chmod 755 pueden llegar al mismo resultado?**
>

**En tu propio ls -l, ¿el Propietario y el Grupo mostraron el mismo nombre? ¿Por qué pasa eso en Ubuntu/Debian?**
>

**¿Por qué un directorio también es, técnicamente, un archivo?**
>

---

## Parte 8 — Reflexión

| Pregunta | Tu respuesta |
|---|---|
| ¿Qué fue lo más difícil de esta lección? | |
| ¿Qué comando te resultó más útil? | |
| ¿Qué pregunta te quedó pendiente? | |
| ¿En qué situación real vas a necesitar chmod +x en tu trabajo? | |

---

## Checklist de logros

- [ ] Creé scripts/saludo.sh con `touch`
- [ ] Escribí su contenido con `nano` y lo guardé (Ctrl+O, Ctrl+X)
- [ ] Verifiqué el contenido con `cat`
- [ ] Reproduje el error "Permiso denegado" al intentar ejecutar mi script
- [ ] Leí e interpreté la cadena de permisos con `ls -l` (las 7 columnas)
- [ ] Entendí por qué Propietario y Grupo pueden mostrar el mismo nombre
- [ ] Distinguí archivo, directorio y carpeta
- [ ] Di permiso de ejecución con `chmod +x`
- [ ] Calculé la equivalencia numérica y confirmé con `chmod 755`
- [ ] Ejecuté mi script con `./scripts/saludo.sh` y vi el mensaje en pantalla

---

*Plantilla CEM-BIO-101 · M1 · Tema 1.5 · Nivel 0*
