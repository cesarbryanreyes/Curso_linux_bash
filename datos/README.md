# Catálogo de datos del curso

Este documento describe **qué datos** usa el curso, **de dónde vienen** y **por qué** los usamos. Las guías de descarga paso a paso están en las carpetas de cada módulo.

---

## Principio general

Todo dato del curso cumple tres reglas:

1. **Es público y trazable** (proviene de NCBI, Ensembl/GENCODE, UniProt o SRA/ENA).
2. **Es real, no de juguete** (así las habilidades son transferibles a tu trabajo).
3. **Está fijado en una versión** (todos partimos exactamente del mismo archivo → reproducibilidad, Noble 2009).

---

## Organismo modelo: *Escherichia coli*

Usamos *E. coli* porque tiene el genoma pequeño (~4.6 Mbp en un solo cromosoma), es el organismo mejor caracterizado de la biología molecular, sus cepas de laboratorio son seguras (no patógenas) y el **Experimento de Evolución a Largo Plazo (LTEE)** de Richard Lenski (desde 1988) le da un contexto biológico atractivo.

---

## Datasets por módulo

### M0 — Paquete del curso (lecturas FASTQ)
- **Qué:** subset recortado de lecturas Illumina de una población del LTEE (cepa ancestral *E. coli* B REL606), run **SRR2589044**.
- **Formato:** `.tar` → `SRR2589044_1.trim.sub.fastq` (~58 MB, 175 000 lecturas).
- **Fuente:** SRA (NCBI); alojado en el **Release `v1.0`** de este repo para consistencia.
- **Por qué:** el FASTQ es la materia prima de la genómica; lo usamos para manipular texto (M2) y control de calidad con FastQC (M4).
- **Guía:** [`../M0_preparacion/README.md`](../M0_preparacion/README.md)

### M1 — Genoma de referencia *E. coli* K-12 MG1655
- **Qué:** ensamblaje de referencia **ASM584v2** (`GCF_000005845.2`), cromosoma `NC_000913.3` (~4.64 Mbp, secuencia única).
- **Formato:** `.fna.gz` → `.fna` (FASTA).
- **Fuente:** NCBI RefSeq.
- **Por qué:** un FASTA único y bien definido es ideal para aprender a navegar el sistema de archivos e inspeccionar secuencias (M1).
- **Guía:** [`../M1_fundamentos/README.md`](../M1_fundamentos/README.md)

### M2 — Anotación GENCODE + proteoma UniProt *(próximamente)*
- **GENCODE (vía Ensembl):** anotación génica en `GFF3`/`GTF` → ideal para practicar `grep` (Tema 2.4).
- **UniProt:** proteoma de referencia de *E. coli* K-12 (~4 500 proteínas) en FASTA → ideal para `awk` (Tema 2.5).

### M4 — Lecturas FASTQ crudas para FastQC *(próximamente)*
- **Qué:** lecturas crudas (SRA/ENA) para ejecutar control de calidad con FastQC.

---

## Bases de datos públicas usadas

| Base | Qué aporta |
|---|---|
| **NCBI** | Genomas de referencia (RefSeq/GenBank) y lecturas crudas (SRA). |
| **Ensembl / GENCODE** | Anotación génica de referencia (GFF3/GTF). |
| **UniProt** | Secuencias y anotación de proteínas (proteomas FASTA). |
| **SRA / ENA** | Lecturas de secuenciación crudas (FASTQ). |

---

## Verificación de integridad

Tras descargar, confirma siempre el tamaño y las primeras líneas del archivo (`ls -lh`, `head`). Si algo no coincide con lo documentado en la guía del módulo, vuelve a descargar.
