# Generador de PDF con Flutter

Aplicación desarrollada en **Flutter y Dart** que permite generar archivos PDF a partir de texto ingresado por el usuario.

El usuario puede indicar el nombre del documento, escribir el contenido que desea incluir y generar un archivo PDF que se guarda automáticamente en la carpeta de **Descargas** del dispositivo.

## Funcionalidades
- Ingresar el nombre del archivo.
- Escribir el contenido que tendrá el PDF.
- Generar archivos en formato PDF.
- Agregar automáticamente la extensión `.pdf`.
- Utilizar `documento.pdf` como nombre predeterminado si no se especifica uno.
- Guardar el PDF generado en la carpeta de Descargas.
- Mostrar una confirmación cuando el archivo se genera correctamente.
- Compartir el PDF generado desde la aplicación.
- Interfaz sencilla con diseño en colores morados pastel.

## Tecnologías utilizadas
- Flutter
- Dart
- PDF
- Printing

## Dependencias
El proyecto utiliza las siguientes dependencias:

````yaml
dependencies:
  flutter:
    sdk: flutter
  pdf:
  printing:

Las dependencias pueden instalarse utilizando:
flutter pub add pdf
flutter pub add printing

## Funcionamiento
El funcionamiento de la aplicación sigue el siguiente proceso:

1. El usuario ingresa el nombre del archivo.
2. El usuario escribe el contenido que desea convertir a PDF.
3. Presiona el botón **Generar PDF**.
4. La aplicación crea el documento PDF.
5. El archivo se guarda en la carpeta **Descargas** del dispositivo.
6. La aplicación confirma que el PDF fue generado correctamente.
7. Se habilita la opción **Compartir PDF**.

##  Ejecutar el proyecto
Primero se deben instalar las dependencias:
flutter pub get
Luego se puede ejecutar la aplicación con:
flutter run
Para comprobar los dispositivos disponibles:
flutter devices
También se puede ejecutar directamente en un dispositivo específico:
flutter run -d ID_DEL_DISPOSITIVO
## Estructura principal
lib/
├── main.dart
└── generadordepdf.dart
### `main.dart`
Contiene la interfaz gráfica de la aplicación y controla las acciones del usuario, como generar, guardar y compartir el PDF.
### `generadordepdf.dart`
Contiene la función encargada de crear el documento PDF utilizando el texto proporcionado por el usuario.

## Ejemplo
Si el usuario ingresa:
Nombre:
Tarea Flutter

Contenido:
Este documento fue generado utilizando Flutter y Dart.

La aplicación genera:
Tarea Flutter.pdf
y lo almacena en la carpeta de Descargas.

## Objetivo del proyecto
Desarrollar una aplicación móvil sencilla utilizando Flutter y Dart que permita transformar texto ingresado por el usuario en un documento PDF, almacenarlo en el dispositivo y permitir posteriormente compartirlo.
