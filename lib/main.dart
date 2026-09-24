import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'generadordepdf.dart';
import 'dart:io';
import 'dart:typed_data';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F3FF),
      ),

      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController textoController = TextEditingController();
  Uint8List? pdfGenerado;
  String? nombrePdf;
  String? rutaPdf;

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const SizedBox(height: 20),

                // ICONO
                Center(
                  child: Container(
                    width: 80,
                    height: 80,

                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE4FF),
                      borderRadius: BorderRadius.circular(24),
                    ),

                    child: const Icon(
                      Icons.picture_as_pdf_rounded,
                      size: 42,
                      color: Color(0xFF8B5CF6),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // TÍTULO
                const Text(
                  'Generador de PDF',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF39275C),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Convierte tu texto en un documento PDF',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF786A8F),
                  ),
                ),

                const SizedBox(height: 32),

                // TARJETA PRINCIPAL
                Container(
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),

                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // NOMBRE
                      const Text(
                        'Nombre del archivo',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A3768),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: nombreController,

                        decoration: InputDecoration(
                          hintText: 'Ejemplo: tarea_flutter',

                          prefixIcon: const Icon(
                            Icons.description_outlined,
                            color: Color(0xFF9B7FE8),
                          ),

                          filled: true,
                          fillColor: const Color(0xFFFAF8FF),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Color(0xFFE7DDF8),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Color(0xFF9B7FE8),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // CONTENIDO
                      const Text(
                        'Contenido del PDF',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A3768),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: textoController,
                        maxLines: 10,

                        decoration: InputDecoration(
                          hintText: 'Escribe aquí el contenido...',

                          filled: true,
                          fillColor: const Color(0xFFFAF8FF),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Color(0xFFE7DDF8),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Color(0xFF9B7FE8),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // GENERAR PDF
                      SizedBox(
                        height: 55,

                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final texto = textoController.text;

                            String nombre =
                                nombreController.text.trim();

                            if (nombre.isEmpty) {
                              nombre = 'documento';
                            }

                            if (!nombre
                                .toLowerCase()
                                .endsWith('.pdf')) {
                              nombre = '$nombre.pdf';
                            }

                            final pdf =
                                await generarPdf(texto);

                            final directorio = Directory(
                              '/storage/emulated/0/Download',
                            );

                            final archivo = File(
                              '${directorio.path}/$nombre',
                            );

                            await archivo.writeAsBytes(pdf);

                            setState(() {
                              pdfGenerado = pdf;
                              nombrePdf = nombre;
                              rutaPdf = archivo.path;
                            });

                            if (mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'PDF guardado en Descargas: $nombre',
                                  ),
                                ),
                              );
                            }
                          },

                          icon: const Icon(
                            Icons.download_rounded,
                          ),

                          label: const Text(
                            'Generar PDF',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF8B5CF6),

                            foregroundColor: Colors.white,

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),

                      // SOLO APARECE CUANDO EXISTE PDF
                      if (pdfGenerado != null) ...[

                        const SizedBox(height: 16),

                        Container(
                          padding: const EdgeInsets.all(14),

                          decoration: BoxDecoration(
                            color: const Color(0xFFF0E9FF),

                            borderRadius:
                                BorderRadius.circular(14),
                          ),

                          child: Row(
                            children: [

                              const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFF7653C7),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  '$nombrePdf generado correctamente',
                                  style: const TextStyle(
                                    color: Color(0xFF5B3E9E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          height: 52,

                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await Printing.sharePdf(
                                bytes: pdfGenerado!,
                                filename: nombrePdf!,
                              );
                            },

                            icon: const Icon(
                              Icons.share_rounded,
                            ),

                            label: const Text(
                              'Compartir PDF',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  const Color(0xFF7653C7),

                              side: const BorderSide(
                                color: Color(0xFFB69DF8),
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}
