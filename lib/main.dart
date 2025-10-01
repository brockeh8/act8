import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // <-- add this

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SwipeScreens(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.black; // <-- text color state

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = _textColor;
        return AlertDialog(
          title: Text('Pick a text color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (color) {
                tempColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Select'),
              onPressed: () {
                setState(() => _textColor = tempColor);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens), // <-- color picker icon
            onPressed: _pickColor,
          ),
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24, color: _textColor), // <-- apply color
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

class SecondFadingTextAnimation extends StatefulWidget {
  @override
  _SecondFadingTextAnimationState createState() => _SecondFadingTextAnimationState();
}

class _SecondFadingTextAnimationState extends State<SecondFadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.blue; // <-- text color state

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = _textColor;
        return AlertDialog(
          title: Text('Pick a text color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (color) {
                tempColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Select'),
              onPressed: () {
                setState(() => _textColor = tempColor);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Fading Animation'),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens), // <-- color picker icon
            onPressed: _pickColor,
          ),
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 3),
          child: Text(
            'This is the second screen!',
            style: TextStyle(fontSize: 24, color: _textColor), // <-- apply color
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

// Wrap both screens inside PageView
class SwipeScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        FadingTextAnimation(),        // First screen
        SecondFadingTextAnimation(),  // Second screen
      ],
    );
  }
}
