# Bitácora M1 · Tema 1.4 — Creación, Copia, Movimiento y Eliminación de Archivos

**Nombre:** <!-- escribe tu nombre aquí -->
**Fecha:** <!-- dd/mm/yyyy -->
**Sistema operativo:** <!-- Windows + WSL2 / macOS / Linux nativo -->

---

## Parte 1 — touch

```bash
$ touch doc/notas_M1.txt
$ ls -lh doc/
# Mi salida:

```

¿Qué diferencia hay entre crear un archivo con `touch` y crear uno que ya existía?
>

---

## Parte 2 — cp

```bash
$ cp data/reference/GCF_000005845.2_ASM584v2_genomic.fna results/copia_prueba.fna
$ ls -lh data/reference/ results/
# Tamaño de ambos archivos:

```

¿Coinciden los tamaños del original y la copia? Sí / No

¿Qué pasó cuando intentaste copiar una carpeta completa sin la bandera `-r`?
>

¿Por qué es importante que `cp` no altere el archivo original en `data/reference/`?
>

---

## Parte 3 — mv

```bash
$ mv results/copia_prueba.fna results/genoma_backup.fna
$ mv results/genoma_backup.fna data/reference/
$ ls -lh data/reference/
# Confirmación de que el archivo se movió:

```

Explica con tus propias palabras por qué `mv` sirve tanto para mover como para renombrar:
>

---

## Parte 4 — rm y rmdir

```bash
$ rm -i results/genoma_backup.fna
# ¿Qué te preguntó la terminal?

$ mkdir carpeta_prueba
$ rmdir carpeta_prueba
# ¿Funcionó? Sí / No

$ touch carpeta_prueba_2/archivo.txt   # (si la carpeta no existe, prueba mkdir -p primero)
$ rmdir carpeta_prueba_2
# ¿Funcionó esta vez? Sí / No — ¿por qué?
```

¿Por qué `rm` no tiene una "papelera de reciclaje" como Windows o Mac?
>

¿Qué hace la bandera `-i` y por qué es recomendable usarla mientras aprendes?
>

---

## Parte 5 — find

```bash
$ find . -name "*.fna"
# Mi resultado:

```

¿El resultado coincide con la ubicación real de tu genoma (`data/reference/`)? Sí / No

¿Para qué situación futura crees que te va a servir más `find`?
>

---

## Parte 6 — Autoevaluación conceptual

**¿Cuál es la diferencia principal entre `cp` y `mv`?**
>

**¿Por qué el genoma en `data/reference/` nunca debería modificarse directamente? Relaciona tu respuesta con Noble (2009).**
>

**¿Qué representa el `.` y qué representa el `*` en `find . -name "*.fna"`?**
>

---

## Parte 7 — Reflexión

| Pregunta | Tu respuesta |
|---|---|
| ¿Qué comando usaste para respaldar el genoma sin tocar el original? | |
| ¿Qué fue lo más difícil de esta lección? | |
| ¿Qué pregunta te quedó pendiente? | |
| ¿Cómo aplicarías rm -i en un proyecto real de tu laboratorio? | |

---

## Checklist de logros

- [ ] Creé un archivo vacío con `touch`
- [ ] Copié el genoma a `results/` con `cp`, sin alterar `data/reference/`
- [ ] Copié una carpeta completa con `cp -r`
- [ ] Renombré y moví un archivo con `mv`
- [ ] Eliminé un archivo con `rm -i`, confirmando antes de borrar
- [ ] Comprobé que `rmdir` solo funciona con carpetas vacías
- [ ] Encontré el genoma con `find . -name "*.fna"`

---

*Plantilla CEM-BIO-101 · M1 · Tema 1.4 · Nivel 0*
