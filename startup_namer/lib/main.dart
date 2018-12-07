import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'startup Name Generator',
      home: new RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestion = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );    
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      /**
       * O callback itemBuilder é chamado uma vez por pareamento de palavras sugerido e coloca cada sugestão
       * em um ListTilerow. Para linhas pares, a função adiciona uma linha ListTile para o pareamento de palavras. 
       * Para linhas ímpares, a função adiciona um widget de divisão para separar visualmente as entradas. 
       * Observe que o divisor pode ser difícil de ver em dispositivos menores.
       */
      itemBuilder: (BuildContext _context, int i) {
         /**
          * Adicione um widget divisor de um pixel de altura antes de cada linha no ListView.
          */ 
        if (i.isOdd) {
          return Divider();
        }
        /**
         * A sintaxe "i ~ / 2" divide i por 2 e retorna um resultado inteiro. 
         * Por exemplo: 1, 2, 3, 4, 5 se torna 0, 1, 1, 2, 2. Isso calcula o número real de pares de palavras no ListView, 
         * menos os widgets do divisor.
         */
        final int index = i ~/ 2;
        /**
         * Se você chegou ao final dos pares de palavras disponíveis ...
         */
        if (index >= _suggestion.length) {
          /**
           * ... depois, gere mais 10 e adicione-os à lista de sugestões.
           */
          _suggestion.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestion[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
