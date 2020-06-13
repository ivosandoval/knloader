# knloader

Game Launcher for ZX Spectrum Next

[![Demo Video](./img/Demo.gif)](./img/Demo.mp4 "Demo")

Do you have a ZX Spectrum Next, but you are tired to remember which is the best option to launch your programs? knloader to the rescue!

This a set of NextBASIC programs which you can configure to remember, and then use, your preferred way to launch other programs (Next/+3e Mode, 128K mode, USR 0, etc.). As a bonus, you can put some images (like cassette covers or loading screens).

This program is not a replacement for the incoportaded Browser, nor offers any other function than to launch other programs.

---

## English

A ZIP file with the latest version is available following [this link](https://github.com/kounch/knloader/releases/latest)

### Software Requirements

- **NextZXOS (version 1.3.2)**. Docs, downloads, etc. [here](https://www.specnext.com/latestdistro/)

### Installation

- Create manually `knloader.bdt` file using the text editor of your choice. See the included manual (PDF or GDE) for instructions.

- Copy together `knloader.bas`, `knlauncher`, `knzml` and the new `knloader.bdt` file to any place in your SD card.

#### Use

Use the browser or command line to navigate to the folder where `knloader.bas`, `knlauncher`, `knzml` and `knloader.bdt` are. Load `knloader.bas`.

On first run, cache files will be created from the data inside database file `knloader.bdt`. This has to be done only once, or after any changes are made to the database file.

![First Boot](./docs/FirstBoot.png)

The main interface shows a list of the programs found in the database file.

![First Boot](./docs/CoverOff.png)

You can use the cursor keys or a joystick (Kempston or MD) to move and select the program that you want to load. Then, press `ENTER`, `0` or the joystick button to launch.

---

### Frequently Asked Questions

- **How many loading modes are there?**

At the moment, the loading mode can be one of these (TZX and Pi audio modes require an accelerated Next to function properly):

    0  - 3DOS (Next)
    1  - TAP
    2  - TZX (fast)
    3  - DSK (AUTOBOOT)
    4  - TAP (USR 0)
    5  - TZX (USR0 - Fast)
    6  - TAP (Next)
    7  - TZX (Next - Fast)
    8  - DSK (Custom Boot)
    9  - TAP (PI Audio)
    10 - TZX
    11 - TAP (USR 0 - PI Audio)
    12 - TZX (USR 0)
    13 - TAP (PI Audio - Next)
    14 - TZX (Next)
    15 - NEX
    16 - Snapshot (Z80, SNX, SNA, etc.)
    17 - Z-Machine Program
    18 - 3DOS

- **What formats are supported for the images?**

The file must be a full ZX Spectrum Next screen image file. It can be in SCR, SLR, SHC, SL2 or BMP format.

- **Does this software write anything to the SD card?**

The programs create a preferences file named `opts.tmp` inside the same folder where `knloader.bas` is installed.

They also create a variable number of cache files inside `/tmp/knloader`. This is necessary to speed up the program execution and overcome RAM limitations for large database files. However, if the database file is not changed, these will become read only on all subsequent executions.

For all other operations, temporary files are created in the RAM disk.

---

## Castellano

Se puede obtener un fichero ZIP con la última versión siguiendo  [este enlace](https://github.com/kounch/knloader/releases/latest).

### Requisitos de Software

- **NextZXOS (versión 1.3.2)**. Documentos, descargas, etc. [aquí](https://www.specnext.com/latestdistro/).

### Instalación

- Crear manualmente un archivo `knloader.bdt` con un programa editor de texto. Veáse el manual incluído (PDF o GDE) para más instrucciones.

- Copiar, juntos, `knloader.bas`, `knlauncher`, `knzml` y el nuevo archivo `knloader.bdt` al lugar que se desee de la tarjeta SD.

#### Uso

Acceder usando el programa Browser, o con otro método, hasta la carpeta donde están `knloader.bas`, `knlauncher`, `knzml` y `knloader.bdt`. Cargar `knloader.bas`.

En la primera ejecución, se crearán archivos de caché desde la información del archivo de datos `knloader.bdt`. Esto sólo tiene que hacerse una vez, o tras haber realizado algún cambio en el archivo de datos.

![First Boot](./docs/FirstBoot.png)

La interfaz principal muestra una lista de los programas encontrados en el archivo de datos.

![First Boot](./docs/CoverOff.png)

Se pueden utilizar las teclas de cursor o un joystick compatible (modo Kempston o MD) para moverse y elegir el programa a cargar. Entonces, pulsar `ENTER`, `0` o el botón del joystick para ejecutarlo.

---

### Preguntas frecuentes

- **¿Cuántos modos de carga hay?**

En este momento, el modo de carga puede ser uno de los siguientes (los modos TZX y Pi Audio requieren un ZX Spectrum Next Accelerated para funcionar correctamente):

    0  - 3DOS (Next)
    1  - TAP
    2  - TZX (rápido)
    3  - DSK (auto arranque)
    4  - TAP (USR 0)
    5  - TZX (USR0 - rápido)
    6  - TAP (Next)
    7  - TZX (Next - rápido)
    8  - DSK (arranque personalizado)
    9  - TAP (PI Audio)
    10 - TZX
    11 - TAP (USR 0 - PI Audio)
    12 - TZX (USR 0)
    13 - TAP (PI Audio - Next)
    14 - TZX (Next)
    15 - NEX (Next)
    16 - Snapshot
    17 - Programa de Z-Machine (Next)
    18 - 3DOS

- **¿Qué formatos pueden tener las imágenes?**

Debe ser un archivo de imagen de pantalla completa. Puede ser en el formato SCR, SLR, SHC, SL2 o BMP.

- **¿Se modifican o crean datos en la tarjeta SD?**

Los programas crean un archivo de preferencias llamado `opts.tmp` en la misma carpeta donde se encuentre `knloader.bas`.

También crean un número variable de archivos de caché en `/tmp/knloader`. Esto es algo necesario para que la ejecución del programa sea a una velocidad adecuada, así como para superar limitaciones de RAM para archivos de datos grandes. Sin embargo, si no se modifica el archivo de datos, estos nuevos ficheros serán de sólo lectura en todas las ejecuciones posteriores.

Para las demás operaciones, se crean ficheros temporales en el disco RAM.

---

## Copyright

Copyright (c) 2020 kounch

Some of the code used to launch programs has been adapted from the official NextZXOS distribution (especifically from `browser.cfg`, `tapload.bas` and `tzxload.bas`).

**_Spectrum Next_** and **_System/Next_** are © **SpecNext Ltd**.

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE
