# Entrada #0 — Preparación del entorno (M0)

**Fecha:** _(completar)_
**Sistema operativo:** _(Windows+WSL2 / macOS / Linux)_

## Qué hice

- Instalé/abrí mi terminal Linux y la verifiqué:

```bash
whoami
pwd
cat /etc/os-release
```

- Creé mi carpeta de trabajo con la estructura del curso:

```bash
mkdir -p ~/Cursos_bioinformatica/curso_linux_bash/data/raw_reads
cd ~/Cursos_bioinformatica/curso_linux_bash
mkdir -p results scripts doc
ls
```

- Descargué y descomprimí el paquete de datos del curso:

```bash
cd data/raw_reads
wget https://github.com/cesarbryanreyes/Curso_linux_bash/releases/download/v1.0/sub.tar
tar -xvf sub.tar
ls -lh
```

## Qué obtuve

- Archivo `SRR2589044_1.trim.sub.fastq` (58 MB, 175 000 lecturas).

## Reflexión

- **Lo que más me costó:** _(completar)_
- **Una pregunta que me queda:** _(completar)_
