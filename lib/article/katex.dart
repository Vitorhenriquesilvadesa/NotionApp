import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';

class KatexEquation extends StatefulWidget {
  const KatexEquation({super.key, required this.value});

  final String value;

  @override
  State<KatexEquation> createState() => _KatexEquationState();
}

class _KatexEquationState extends State<KatexEquation> {
  @override
  Widget build(BuildContext context) {
    Widget result;

    try {
      var parser = TexParser(widget.value, TexParserSettings());
      parser.parse();

      var ast = SyntaxTree(greenRoot: parser.parse());
      debugPrint("Chegou aqui");

      result = Column(
        children: [
          Math.tex(
            widget.value,
            textStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      );
    } catch (e) {
      result = Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Equation with errors.",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      );
    }

    return result;
  }
}
