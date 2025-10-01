import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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

// ------------------- First Screen -------------------
class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.black;

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
            icon: Icon(Icons.color_lens),
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
            style: TextStyle(fontSize: 24, color: _textColor),
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

// ------------------- Second Screen -------------------
class SecondFadingTextAnimation extends StatefulWidget {
  @override
  _SecondFadingTextAnimationState createState() =>
      _SecondFadingTextAnimationState();
}

class _SecondFadingTextAnimationState extends State<SecondFadingTextAnimation>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  Color _textColor = Colors.blue;

  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    // Rotation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds:1),
    );

    // Apply easeIn curve
    _rotation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.repeat(); // keeps rotating forever
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            icon: Icon(Icons.color_lens),
            onPressed: _pickColor,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 3),
              child: Text(
                'This is the second screen!',
                style: TextStyle(fontSize: 24, color: _textColor),
              ),
            ),
            SizedBox(height: 40),
            RotationTransition(
              turns: _rotation,
              child: Image.network(
                'https://plus.unsplash.com/premium_photo-1673643260141-2fa3c98ef333?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                width: 300,
                height: 300,
                
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

// ------------------- PageView -------------------
class SwipeScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal, // swipe left/right
      children: [
        FadingTextAnimation(), // First screen
        SecondFadingTextAnimation(), // Second screen
      ],
    );
  }
}
