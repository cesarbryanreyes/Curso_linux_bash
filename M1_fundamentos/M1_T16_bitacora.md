# Bitácora M1 · Tema 1.6 — Flujos Estándar, Redirecciones y Pipes

**Nombre:** <!-- escribe tu nombre aquí -->
**Fecha:** <!-- dd/mm/yyyy -->
**Sistema operativo:** <!-- Windows + WSL2 / macOS / Linux nativo -->

---

## Parte 1 — Los tres canales

Responde con tus propias palabras:

- ¿Qué es stdin?
>

- ¿Qué es stdout?
>

- ¿Qué es stderr?
>

- ¿Cuál es el destino por defecto de stdout y stderr si no rediriges nada?
>

---

## Parte 2 — Redirección básica con `>` y `>>`

```bash
$ echo "Hola Bash" > saludo.txt
$ cat saludo.txt
# Mi salida:

$ echo "Segunda línea" >> saludo.txt
$ cat saludo.txt
# Mi salida:
```

¿Qué pasó con el contenido de `saludo.txt` la primera vez que usaste `>`? ¿Y qué pasó al usar `>>`?
>

¿Qué diferencia hay entre `>` y `>>`? Explica el riesgo de usar `>` sin darte cuenta.
>

---

## Parte 3 — Redirigir con otros comandos

```bash
$ ls -lh data/reference/ > doc/inventario.txt
$ cat doc/inventario.txt
# Mi salida:

$ date >> doc/inventario.txt
$ cat doc/inventario.txt
# Mi salida:
```

¿Por qué `>` y `>>` funcionan igual con `ls`, `date` o cualquier otro comando?
>

---

## Parte 4 — Separar errores con `2>`

```bash
$ ls carpeta_que_no_existe 2> errores.log
# ¿Qué apareció en pantalla?

$ cat errores.log
# Mi salida:
```

¿Para qué situación real de bioinformática usarías `2>` (separar errores de resultados)?
>

---

## Parte 5 — Pipes básicos

```bash
$ echo "hola mundo bioinformática" | wc -w
# Mi resultado:

$ ls data/reference/ | wc -l
# Mi resultado:

$ history | tail -5
# Mis últimos 5 comandos:
```

Construye tu propia pipe usando `echo`, `ls` o `history` (distinta a los ejemplos de arriba) y pega el comando y su resultado:
>

---

## Parte 6 — Pipe aplicada a tu genoma

```bash
$ grep ">" data/reference/GCF_000005845.2_ASM584v2_genomic.fna | wc -l
# Mi resultado:

# Valor esperado: 1
# ¿Coincide? Sí / No
```

```bash
$ grep -v ">" data/reference/GCF_000005845.2_ASM584v2_genomic.fna | tr -d '\n' | wc -c
# Mi resultado:

# Valor esperado: 4641652
# ¿Coincide? Sí / No
```

Explica con tus propias palabras qué hace cada uno de los 3 comandos de esta pipe:
- `grep -v ">"` →
- `tr -d '\n'` →
- `wc -c` →

---

## Parte 7 — Autoevaluación conceptual

**¿Cuál es la diferencia entre stdout y stderr?**
>

**¿Por qué a veces conviene mandar stdout y stderr a archivos separados?**
>

**Explica con la analogía de la vía metabólica cómo funciona una pipe:**
>

---

## Parte 8 — Reflexión

| Pregunta | Tu respuesta |
|---|---|
| ¿Qué pipe básica construiste tú mismo? | |
| ¿Qué resultado obtuviste al contar las bases de tu genoma con tu propia pipe? | |
| ¿Qué fue lo más difícil de este tema? | |
| ¿Qué pregunta te quedó pendiente? | |

---

## Checklist de logros

- [ ] Explico qué son stdin, stdout y stderr
- [ ] Uso `>` para sobreescribir un archivo con la salida de un comando
- [ ] Uso `>>` para añadir sin borrar lo anterior
- [ ] Uso `2>` para redirigir solo los errores
- [ ] Construí mi propia pipe con `echo`, `ls` o `history`
- [ ] Usé `grep ">" | wc -l` para contar secuencias en mi genoma
- [ ] Reproduje la pipe de 3 pasos que calcula 4,641,652 bp y entiendo cada paso

---

## Cierre del Módulo 1

Con este tema completaste el Módulo 1 — Fundamentos de Linux. Siguiente paso: Quiz asincrónico M1 (20 preguntas) y tu Bitácora #1 completa en GitHub.

---

*Plantilla CEM-BIO-101 · M1 · Tema 1.6 · Nivel 0*
