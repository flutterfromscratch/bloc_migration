import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FakeNetworkService {
  final _stream = StreamController<String>();

  Future<String> longRunningOperation() async {
    await Future.delayed(Duration(seconds: 3));
    return "Long running operation completed";
  }

  Stream<String> longRunningStream() async* {
    for (var i = 0; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield 'Request is ${i * 10}% complete. ';
    }
  }

  Stream<ComplexStreamResponse> longRunningComplexStream() async* {
    for (var i = 0; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield ComplexStreamResponse("Complex stream response $i", i % 2 == 0 ? Icons.eleven_mp : Icons.eleven_mp_outlined);
    }
  }
}

class ComplexStreamResponse {
  final String message;
  final IconData icon;

  ComplexStreamResponse(this.message, this.icon);
}
