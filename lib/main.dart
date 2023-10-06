import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glossário de Direito Digital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GlossaryPage(),
    );
  }
}

class GlossaryPage extends StatelessWidget {
  final glossaryTerms = [
    GlossaryTerm(
      name: 'Termo 1',
      concept:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur convallis venenatis lectus, at cursus justo finibus at. ',
      image: 'assets/images/termo1.jpg',
      references: [
        'https://pt.wikipedia.org/wiki/Direito_digital',
        'Referência 2',
      ],
    ),
    GlossaryTerm(
      name: 'Termo 2',
      concept:
          'Nulla facilisis justo augue, vitae placerat lectus fermentum et. Integer cursus ante et mi consectetur, ac aliquet ex elementum.',
      image: 'assets/images/termo2.jpg',
      references: [
        'Confia',
        'Referência 4',
      ],
    ),
    // Adicione os demais termos aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Glossário de Direito Digital'),
      ),
      body: ListView.builder(
        itemCount: glossaryTerms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(glossaryTerms[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TermDetailPage(glossaryTerm: glossaryTerms[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TermDetailPage extends StatelessWidget {
  final GlossaryTerm glossaryTerm;

  const TermDetailPage({required this.glossaryTerm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(glossaryTerm.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              glossaryTerm.concept,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Center(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Image.asset(
                  glossaryTerm.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Referências:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...glossaryTerm.references.map((reference) {
              return GestureDetector(
                onTap: () => launch(reference),
                child: Text(
                  reference,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class GlossaryTerm {
  final String name;
  final String concept;
  final String image;
  final List<String> references;

  const GlossaryTerm({
    required this.name,
    required this.concept,
    required this.image,
    required this.references,
  });
}
