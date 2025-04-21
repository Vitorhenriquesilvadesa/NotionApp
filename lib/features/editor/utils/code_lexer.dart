import 'dart:collection';

// Definindo os tipos de tokens
enum TokenType {
  keyword,
  identifier,
  number,
  string,
  operator,
  punctuation,
  eof,
  space,
  newLine,
  comment,
}

// Classe que representa um token
class Token {
  final TokenType type;
  final String lexeme;
  final dynamic literal;
  final int line;

  Token(this.type, this.lexeme, this.literal, this.line);

  @override
  String toString() {
    return '$type $lexeme $literal';
  }
}

// Scanner para ler o código Python e gerar tokens
class PythonScanner {
  final String source;
  int _start = 0;
  int _current = 0;
  int _line = 1;
  final List<Token> _tokens = [];

  static final Set<String> _keywords = {
    'and',
    'as',
    'assert',
    'break',
    'class',
    'continue',
    'def',
    'del',
    'elif',
    'else',
    'except',
    'False',
    'finally',
    'for',
    'from',
    'global',
    'if',
    'import',
    'in',
    'is',
    'lambda',
    'None',
    'nonlocal',
    'not',
    'or',
    'pass',
    'raise',
    'return',
    'True',
    'try',
    'while',
    'with',
    'yield',
  };

  PythonScanner(this.source);

  List<Token> scanTokens() {
    while (!_isAtEnd()) {
      _start = _current;
      _scanToken();
    }
    _tokens.add(Token(TokenType.eof, '', null, _line));
    return _tokens;
  }

  bool _isAtEnd() => _current >= source.length;

  void _scanToken() {
    final char = _advance();
    switch (char) {
      // Punctuation
      case '(':
      case ')':
      case '[':
      case ']':
      case '{':
      case '}':
      case ',':
      case '.':
      case ':':
      case ';':
        _addToken(TokenType.punctuation);
        break;

      case '#':
        _comment();
        break;

      // Operators
      case '-':
        if (_match(">")) {
          _addToken(TokenType.punctuation);
        } else {
          _addToken(TokenType.operator);
        }
      case '+':
      case '!':
      case '>':
      case '<':
      case '*':
      case '/':
      case '%':
      case '=':
        _addToken(TokenType.operator);
        break;

      // Whitespaces
      case ' ':
      case '\r':
      case '\t':
        _addToken(TokenType.space);
        break; // Ignora espaços em branco
      case '\n':
        _addToken(TokenType.newLine);
        _line++;
        break;

      // String
      case '"':
      case "'":
        _string(char);
        break;

      // Number
      default:
        if (_isDigit(char)) {
          _number();
        } else if (_isAlpha(char)) {
          _identifier();
        } else {
          print("Unexpected character: $char at line $_line");
        }
        break;
    }
  }

  void _comment() {
    while (_peek() != '\n' && !_isAtEnd()) {
      _advance();
    }
    _addToken(TokenType.comment);
  }

  void _identifier() {
    while (_isAlphaNumeric(_peek())) {
      _advance();
    }
    final text = source.substring(_start, _current);
    final type =
        _keywords.contains(text) ? TokenType.keyword : TokenType.identifier;
    _addToken(type);
  }

  void _string(String quote) {
    while (_peek() != quote && !_isAtEnd()) {
      if (_peek() == '\n') _line++;
      _advance();
    }

    if (_isAtEnd()) {
      print("Unterminated string at line $_line.");
      return;
    }

    _advance();
    final value = source.substring(_start + 1, _current - 1);
    _addToken(TokenType.string, value);
  }

  void _number() {
    while (_isDigit(_peek())) {
      _advance();
    }
    if (_peek() == '.' && _isDigit(_peekNext())) {
      _advance();
      while (_isDigit(_peek())) {
        _advance();
      }
    }

    final value = double.parse(source.substring(_start, _current));
    _addToken(TokenType.number, value);
  }

  void _addToken(TokenType type, [dynamic literal]) {
    final text = source.substring(_start, _current);
    _tokens.add(Token(type, text, literal, _line));
  }

  bool _match(String expected) {
    if (_isAtEnd()) return false;
    if (source[_current] != expected) return false;

    _current++;
    return true;
  }

  String _advance() {
    if (_isAtEnd()) return '0';
    return source[_current++];
  }

  String _peek() {
    if (_isAtEnd()) return '0';
    return source[_current];
  }

  String _peekNext() {
    if (_current + 1 >= source.length) return '0';
    return source[_current + 1];
  }

  bool _isDigit(String c) => c.compareTo('0') >= 0 && c.compareTo('9') <= 0;

  bool _isAlpha(String c) =>
      (c.compareTo('a') >= 0 && c.compareTo('z') <= 0) ||
      (c.compareTo('A') >= 0 && c.compareTo('Z') <= 0) ||
      c == '_';

  bool _isAlphaNumeric(String c) => _isAlpha(c) || _isDigit(c);
}
