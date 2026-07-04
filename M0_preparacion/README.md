# M0 · Descarga del paquete de datos del curso

> **Tema 0.3** — Descarga del paquete de datos del curso desde bases públicas.
> Formato bitácora: cada bloque trae el **comando**, la **salida esperada** y la **explicación**. Cópialo también en tu bitácora personal.

## Contexto

En el M0 bajamos el **paquete base del curso**: un subset de lecturas FASTQ reales de *Escherichia coli* del Experimento de Evolución a Largo Plazo (LTEE) de Richard Lenski. Lo alojamos en el Release de este repositorio para que **todos partamos exactamente del mismo archivo** (reproducibilidad) y para que una base pública caída no detenga la clase.

---

## PASO 0 — Organiza tu carpeta de trabajo (Noble, 2009)

```bash
# Crear la carpeta raíz del curso y las subcarpetas del proyecto
mkdir -p ~/Cursos_bioinformatica/curso_linux_bash/data/raw_reads
mkdir -p ~/Cursos_bioinformatica/curso_linux_bash/results
mkdir -p ~/Cursos_bioinformatica/curso_linux_bash/scripts
mkdir -p ~/Cursos_bioinformatica/curso_linux_bash/doc
cd ~/Cursos_bioinformatica/curso_linux_bash
ls
```

**Salida esperada:**

```
data  doc  results  scripts
```

**Explicación:** `mkdir -p` crea carpetas (y las intermedias que falten). Esta estructura (`data/`, `results/`, `scripts/`, `doc/`) es el primer hábito de reproducibilidad del curso: un proyecto ordenado es un proyecto replicable.

---

## COMANDO 1 — Descargar el paquete de datos

```bash
cd ~/Cursos_bioinformatica/curso_linux_bash/data/raw_reads
wget https://github.com/cesarbryanreyes/Curso_linux_bash/releases/download/v1.0/sub.tar
```

**Salida esperada (final):**

```
'sub.tar' saved [ ~58M ]
```

**Explicación:** `wget` descarga un archivo desde una URL. Aquí traemos `sub.tar` desde el Release `v1.0` de este repositorio.

---

## COMANDO 2 — Descomprimir el paquete

```bash
tar -xvf sub.tar
ls -lh
```

**Salida esperada:**

```
SRR2589044_1.trim.sub.fastq
-rw-r--r-- 1 usuario usuario 58M ... SRR2589044_1.trim.sub.fastq
```

**Explicación:** `tar -xvf` extrae el contenido de un paquete `.tar` (`-x` extraer, `-v` mostrar el proceso, `-f` indicar el archivo). `ls -lh` lista con el tamaño en formato legible.

---

## COMANDO 3 — Verificar el contenido

```bash
head -8 SRR2589044_1.trim.sub.fastq
```

**Salida esperada:**

```
@SRR2589044.1 1/1
CGCGTCCATTAATCCAGGCGTACGGCAAGCATGAGGTCAGCAAGAGCG...
+
AAFFFKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK...
```

**Explicación:** cada lectura FASTQ ocupa **4 líneas**: identificador, secuencia, separador (`+`) y calidades (codificación Phred+33). Ver 8 líneas = ver 2 lecturas completas.

---

## COMANDO 4 — Contar cuántas lecturas hay

```bash
echo "$(($(cat SRR2589044_1.trim.sub.fastq | wc -l) / 4))"
```

**Salida esperada:**

```
175000
```

**Explicación:** `wc -l` cuenta líneas; dividir entre 4 da el número de lecturas (cada lectura son 4 líneas). **175 000 lecturas contadas en segundos** — imposible en Excel.

---

## Checklist del M0

- [ ] Carpeta de trabajo creada (`data/ results/ scripts/ doc/`).
- [ ] `sub.tar` descargado y descomprimido.
- [ ] `SRR2589044_1.trim.sub.fastq` verificado (58 MB, 175 000 lecturas).
- [ ] Entrada #0 registrada en tu bitácora personal.

> **Origen de los datos:** LTEE de R. Lenski (desde 1988), cepa ancestral *E. coli* B REL606. Fuente: SRA (NCBI).
