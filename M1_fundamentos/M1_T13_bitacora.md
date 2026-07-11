# Bitácora M1 · Tema 1.3 — Navegación del Sistema de Archivos

**Nombre:** <!-- escribe tu nombre aquí -->  
**Fecha:** <!-- dd/mm/yyyy -->  
**Sistema operativo:** <!-- Windows + WSL2 / macOS / Linux nativo -->

---

## Parte 1 — Sistema de archivos y rutas

Ejecuta y completa:

```bash
$ ls /
# Lista el contenido de la raíz del sistema:

```

¿Cuántas carpetas hay en /?  _______________

Explica con tus propias palabras la diferencia entre ruta absoluta y ruta relativa:
>

¿Qué diferencia hay entre `cd ..` y `cd ~`?
>

---

## Parte 2 — Navegar con pwd, ls, cd

```bash
$ pwd
# Mi posición inicial:

$ cd /
$ pwd
# Ahora estoy en:

$ ls -lh /home/
# Contenido de /home/:

$ cd ~
$ pwd
# Volví a:
```

---

## Parte 3 — Crear la estructura del proyecto

```bash
$ mkdir -p ~/curso_linux_bash/{data/raw_reads,data/reference,scripts,results,doc}
$ ls ~/curso_linux_bash/
# Carpetas creadas:

$ ls ~/curso_linux_bash/data/
# Subcarpetas de data/:

```

¿Qué hace la opción `-p` en mkdir?
>

¿Por qué la carpeta `data/` es de solo lectura (nunca se modifica directamente)?
>

¿Por qué `data/` está dividida en `raw_reads/` y `reference/`? ¿Qué tipo de archivo va en cada una?
>

---

## Parte 4 — Descargar el genoma con wget

```bash
$ cd ~/curso_linux_bash/data/reference/
$ pwd
# Confirmación de posición:

$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
# Velocidad de descarga que observé:
# Tiempo que tardó:
# Tamaño del archivo descargado:
```

---

## Parte 5 — Descomprimir e inspeccionar

```bash
$ gunzip GCF_000005845.2_ASM584v2_genomic.fna.gz
$ ls -lh
# Tamaño del archivo descomprimido:
```

### Verificación obligatoria — compara con los valores esperados

```bash
$ head -1 GCF_000005845.2_ASM584v2_genomic.fna
# Mi salida:

# Valor esperado: >NC_000913.3 Escherichia coli str. K-12 substr. MG1655, complete genome
# ¿Coincide? Sí / No
```

```bash
$ grep -c ">" GCF_000005845.2_ASM584v2_genomic.fna
# Mi resultado:

# Valor esperado: 1
# ¿Coincide? Sí / No
# ¿Qué significa biológicamente este resultado?:
```

```bash
$ grep -v ">" GCF_000005845.2_ASM584v2_genomic.fna | tr -d '\n' | wc -c
# Mi resultado:

# Valor esperado: 4641652
# ¿Coincide? Sí / No
# ¿Qué representa este número?:
```

---

## Parte 6 — Vistazo a raw_reads/ (adelanto del Módulo 4)

```bash
$ cd ~/curso_linux_bash/data/raw_reads/
$ ls -lh
# Archivos que encontré:

```

Vas a notar que `raw_reads/` ya contiene un archivo `.fastq` y un `.tar`. No los toques todavía — los usaremos en el Módulo 4 (control de calidad con FastQC). Por ahora, solo confirma que existen:

¿Qué archivo(s) viste en `raw_reads/`?
>

---

## Parte 7 — Autoevaluación conceptual

**¿Qué es el sistema de archivos de Linux y en qué se diferencia de Windows?**
>

**Explica el principio de Noble (2009) con tus propias palabras:**
>

**¿Por qué el archivo se llama .fna.gz? ¿Qué significa cada parte?**
>

**¿Qué información te da la cabecera FASTA (la línea que empieza con >)?**
>

---

## Parte 8 — Reflexión

| Pregunta | Tu respuesta |
|---|---|
| ¿Qué fue lo más difícil de navegar el sistema de archivos? | |
| ¿Qué comando te resultó más útil? | |
| ¿Qué pregunta te quedó pendiente? | |
| ¿Cómo aplicarías esta organización a un proyecto real de tu laboratorio? | |

---

## Checklist de logros

- [ ] Entiendo la diferencia entre ruta absoluta y ruta relativa
- [ ] Sé usar pwd para saber dónde estoy
- [ ] Sé usar ls -lh para listar con detalles
- [ ] Sé navegar con cd, cd .., cd ~, cd -
- [ ] Creé la estructura del proyecto con mkdir -p: `curso_linux_bash/{data/raw_reads,data/reference,scripts,results,doc}`
- [ ] Descargué el genoma en `data/reference/` con wget
- [ ] Descomprimí con gunzip
- [ ] Verifiqué: head -1, grep -c (=1), wc -c (=4641652)
- [ ] Ubiqué los archivos de `data/raw_reads/` (los usaremos en M4)

---

*Plantilla CEM-BIO-101 · M1 · Tema 1.3 · Nivel 0*
