# M1 · Descarga del genoma de referencia desde NCBI

> **Tema 1.3** — Navegación del sistema de archivos, descargando el genoma con `wget` desde NCBI.
> Formato bitácora: **comando → salida esperada → explicación**.

## Contexto

En el M1 descargamos el **genoma de referencia de *Escherichia coli* K-12 MG1655** (ensamblaje ASM584v2, `GCF_000005845.2`) directamente del FTP de **NCBI RefSeq**. Es un archivo FASTA único y bien definido, ideal para aprender a moverte por el sistema de archivos e inspeccionar secuencias sin el tamaño de un genoma eucariota.

> **Nota para el docente:** confirma esta ruta de RefSeq una vez antes de clase; si prefieres máxima fiabilidad en vivo, espeja el `.fna.gz` en el Release de este repo y ajusta la URL.

---

## COMANDO 1 — Preparar la carpeta y descargar el genoma

```bash
# Carpeta dedicada a datos de referencia
mkdir -p ~/Cursos_bioinformatica/curso_linux_bash/data/reference
cd ~/Cursos_bioinformatica/curso_linux_bash/data/reference

# Descargar el genoma comprimido desde NCBI RefSeq
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
```

**Salida esperada (final):**

```
'GCF_000005845.2_ASM584v2_genomic.fna.gz' saved
```

**Explicación:** los genomas en las bases públicas se distribuyen **comprimidos** (`.gz`) para ahorrar espacio y ancho de banda. `wget` los trae tal cual.

---

## COMANDO 2 — Descomprimir

```bash
gunzip GCF_000005845.2_ASM584v2_genomic.fna.gz
ls -lh
```

**Salida esperada:**

```
-rw-r--r-- 1 usuario usuario 4.5M ... GCF_000005845.2_ASM584v2_genomic.fna
```

**Explicación:** `gunzip` descomprime archivos `.gz` (distinto de `.tar`, que se abre con `tar`). Queda el archivo FASTA `.fna` listo para inspeccionar.

---

## COMANDO 3 — Ver la cabecera del FASTA

```bash
head -1 GCF_000005845.2_ASM584v2_genomic.fna
```

**Salida esperada:**

```
>NC_000913.3 Escherichia coli str. K-12 substr. MG1655, complete genome
```

**Explicación:** en un archivo FASTA, las líneas que empiezan con `>` son **cabeceras** (identifican cada secuencia). `NC_000913.3` es el número de acceso RefSeq del cromosoma de *E. coli* K-12 MG1655.

---

## COMANDO 4 — ¿Cuántas secuencias tiene el genoma?

```bash
grep -c ">" GCF_000005845.2_ASM584v2_genomic.fna
```

**Salida esperada:**

```
1
```

**Explicación:** `grep -c ">"` cuenta cuántas líneas de cabecera hay = cuántas secuencias contiene el FASTA. *E. coli* K-12 MG1655 tiene **un solo cromosoma circular** y no plásmido, por eso el resultado es `1`.

---

## COMANDO 5 — Longitud del genoma (en pares de bases)

```bash
grep -v ">" GCF_000005845.2_ASM584v2_genomic.fna | tr -d '\n' | wc -c
```

**Salida esperada (valor de referencia):**

```
4641652
```

**Explicación:** `grep -v ">"` toma todas las líneas *excepto* las cabeceras (la secuencia); `tr -d '\n'` elimina los saltos de línea para unir toda la secuencia; `wc -c` cuenta los caracteres restantes = las bases. El genoma de MG1655 mide **≈ 4 641 652 bp** (~4.64 Mbp).

---

## Checklist del M1

- [ ] Genoma descargado y descomprimido (`.fna`).
- [ ] Cabecera verificada (`NC_000913.3 ... MG1655`).
- [ ] Confirmado: 1 secuencia, ~4.64 Mbp.
- [ ] Bitácora #1 actualizada.
