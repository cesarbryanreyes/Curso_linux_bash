# Bitácora M1 · Tema 1.1 — Fundamentos del Sistema Operativo Linux

**Nombre:** <!-- escribe tu nombre aquí -->  
**Fecha:** <!-- dd/mm/yyyy -->  
**Sistema operativo:** <!-- Windows + WSL2 / macOS / Linux nativo -->  
**Distribución Linux:** <!-- Ubuntu 22.04 / otra -->

---

## Parte 1 — Identidad en el sistema

Ejecuta los comandos y pega la salida real de tu terminal:

```bash
$ whoami
# pega aquí la salida:

$ id
# pega aquí la salida completa:
```

Responde:
- Mi nombre de usuario es: _______________
- Mi UID es: _______________
- Mi GID principal es: _______________
- ¿Aparece "sudo" en mis grupos? Sí / No
  - Si no aparece sudo: ¿qué implicación tiene? _______________

---

## Parte 2 — Variables de entorno

```bash
$ echo $PATH
# pega aquí la salida:

$ echo $HOME
# pega aquí la salida:

$ echo $USER
# pega aquí la salida:
```

Responde:
- ¿Cuántas carpetas tiene tu $PATH? (cuenta los ":") _______________
- ¿Está la carpeta de miniconda en tu $PATH? Sí / No / No tengo miniconda aún
- ¿Qué pasa si instalas una herramienta y su carpeta NO está en el $PATH?

  _______________________________________________________________

---

## Parte 3 — El archivo .bashrc

```bash
$ ls -a ~
# ¿Ves el archivo .bashrc en la lista? Sí / No

$ cat ~/.bashrc
# Pega aquí las primeras 10 líneas de tu .bashrc:
```

Alias que agregaré a mi .bashrc y por qué:
| Alias | Comando completo | ¿Para qué lo usaré? |
|-------|-----------------|---------------------|
| | | |
| | | |

---

## Parte 4 — Procesos

```bash
$ ps aux | wc -l
# ¿Cuántos procesos tienes activos ahora?:

$ top
# (ejecuta top, observa 30 segundos y sal con q)
# ¿Qué proceso consumía más %CPU?:
# ¿Qué proceso consumía más %MEM?:
```

---

## Parte 5 — Autoevaluación conceptual

Responde con tus propias palabras (sin copiar del material):

**¿Cuál es la diferencia entre la terminal y el shell?**

> 

**Explica qué es el $PATH como si se lo explicaras a un compañero de tu laboratorio:**

> 

**¿Por qué en Ubuntu/WSL2 usamos `sudo` y no `su -`?**

> 

**¿Qué hace `source ~/.bashrc` y cuándo lo necesitas?**

> 

---

## Parte 6 — Reflexión personal

| Pregunta | Tu respuesta |
|---|---|
| ¿Qué concepto te quedó más claro? | |
| ¿Qué fue lo más difícil de entender? | |
| ¿Qué pregunta te quedó pendiente? | |
| ¿Cómo aplicarías el $PATH en un análisis real con FastQC? | |

---

## Parte 7 — Checklist de logros

Marca lo que ya puedes hacer:

- [ ] Ejecutar `whoami` y `id` y explicar cada parte de la salida
- [ ] Distinguir entre Terminal (ventana) y Shell/Bash (intérprete)
- [ ] Explicar qué es el UID y el GID con mis propias palabras
- [ ] Saber por qué ocurre `command not found` y cómo solucionarlo
- [ ] Ver el contenido de mi `~/.bashrc` con `cat`
- [ ] Recargar el `.bashrc` con `source ~/.bashrc`
- [ ] Listar procesos activos con `ps aux`
- [ ] Saber que `fastqc` y `FastQC` son cosas distintas para Linux

---

*Plantilla CEM-BIO-101 · M1 · Tema 1.1 · Nivel 0*
