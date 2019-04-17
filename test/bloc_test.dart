import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When A is changed to B, a = b", () {
    // Given
    var a = 'a';

    // When
    a = 'b';

    // Then
    expect(a, 'b');
  });
  
  // Testing RX Streams
  //
  // operatorPressed.add('3');
  // await expectLater(_updateDisplay.stream, emits('3'));
}
