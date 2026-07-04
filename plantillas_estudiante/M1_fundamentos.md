# Bitácora #1 — Fundamentos de Linux (M1)

**Fecha:** _(completar)_

## Navegación del sistema de archivos

```bash
pwd              # ¿dónde estoy?
ls -lh           # ¿qué hay aquí?
cd data/reference
```

## Descarga del genoma de referencia (NCBI)

```bash
mkdir -p ~/Cursos_bioinformatica/curso_linux_bash/data/reference
cd ~/Cursos_bioinformatica/curso_linux_bash/data/reference
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
gunzip GCF_000005845.2_ASM584v2_genomic.fna.gz
```

## Inspección del FASTA

```bash
head -1 GCF_000005845.2_ASM584v2_genomic.fna   # cabecera
grep -c ">" GCF_000005845.2_ASM584v2_genomic.fna   # nº de secuencias -> 1
```

## Operaciones con archivos, permisos y pipes

```bash
# (completar con lo practicado en M1: cp, mv, rm, mkdir, chmod +x, |, >, >>)
```

## Reflexión

- **Comando nuevo que aprendí:** _(completar)_
- **Lo que más me costó:** _(completar)_
- **Una pregunta que me queda:** _(completar)_
