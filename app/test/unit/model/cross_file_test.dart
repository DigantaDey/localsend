import 'dart:convert';

import 'package:localsend_app/model/cross_file.dart';
import 'package:localsend_isolates/model/file_type.dart';
import 'package:test/test.dart';

void main() {
  group('CrossFile.textMessage', () {
    test('Should encode the message as an in-memory text file', () {
      final file = CrossFile.textMessage('hello world');

      expect(file.fileType, FileType.text);
      expect(file.bytes, utf8.encode('hello world'));
      expect(file.size, utf8.encode('hello world').length);
      expect(file.path, isNull);
      expect(file.asset, isNull);
      expect(file.name, endsWith('.txt'));
    });

    test('Should encode UTF-8 correctly', () {
      const message = 'こんにちは 👋';
      final file = CrossFile.textMessage(message);

      expect(file.bytes, utf8.encode(message));
      expect(file.size, utf8.encode(message).length);
    });

    test('Should generate unique names unless a name is provided', () {
      final first = CrossFile.textMessage('a');
      final second = CrossFile.textMessage('a');
      final named = CrossFile.textMessage('a', name: 'custom.txt');

      expect(first.name, isNot(second.name));
      expect(named.name, 'custom.txt');
    });
  });
}
