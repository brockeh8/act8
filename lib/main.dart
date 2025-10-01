import 'package:flutter/material.dart';

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

Future<Color?> showColorPicker(BuildContext context, Color startColor) {
  final colors = <Color>[
    Colors.black, Colors.white, Colors.red, Colors.green, Colors.blue,
    Colors.orange, Colors.purple, Colors.pink, Colors.teal, Colors.amber,
  ];
  Color selected = startColor;

  return showDialog<Color>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Pick a text color'),
      content: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final c in colors)
            GestureDetector(
              onTap: () => selected = c,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected == c ? Colors.blueAccent : Colors.grey,
                    width: selected == c ? 3 : 1,
                  ),
                ),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context, selected), child: const Text('Select')),
      ],
    ),
  );
}

class FadingTextAnimation extends StatefulWidget {
  final bool isDark;
  final VoidCallback? onToggleTheme;

  FadingTextAnimation({Key? key, this.isDark = false, this.onToggleTheme})
      : super(key: key);

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

  void _pickColor() async {
    final picked = await showColorPicker(context, _textColor);
    if (picked != null) {
      setState(() => _textColor = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.isDark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fading Text Animation'),
          automaticallyImplyLeading: false,
          leadingWidth: 120,
          leading: Row(
            children: [
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.color_lens),
                onPressed: _pickColor,
                tooltip: 'Pick text color',
              ),
              IconButton(
                icon: Icon(widget.isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined),
                onPressed: widget.onToggleTheme,
                tooltip: widget.isDark ? 'Light Mode' : 'Dark Mode',
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24, color: _textColor),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: toggleVisibility,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Fade'),
              ),
              // No photo on slide 1
            ],
          ),
        ),
      ),
    );
  }
}

class SecondFadingTextAnimation extends StatefulWidget {
  final bool isDark;
  final VoidCallback? onToggleTheme;

  SecondFadingTextAnimation({Key? key, this.isDark = false, this.onToggleTheme})
      : super(key: key);

  @override
  _SecondFadingTextAnimationState createState() => _SecondFadingTextAnimationState();
}

class _SecondFadingTextAnimationState extends State<SecondFadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.blue;
  bool _showFrame = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _pickColor() async {
    final picked = await showColorPicker(context, _textColor);
    if (picked != null) {
      setState(() => _textColor = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.isDark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Second Fading Animation'),
          automaticallyImplyLeading: false,
          leadingWidth: 120,
          leading: Row(
            children: [
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.color_lens),
                onPressed: _pickColor,
                tooltip: 'Pick text color',
              ),
              IconButton(
                icon: Icon(widget.isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined),
                onPressed: widget.onToggleTheme,
                tooltip: widget.isDark ? 'Light Mode' : 'Dark Mode',
              ),
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 3),
                  child: Text(
                    'hello',
                    style: TextStyle(fontSize: 24, color: _textColor),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: toggleVisibility,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Fade'),
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: const Text('Show Image Frame'),
                  value: _showFrame,
                  onChanged: (v) => setState(() => _showFrame = v),
                ),
                Container(
                  decoration: _showFrame
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          ),
                        )
                      : null,
                  padding: _showFrame ? const EdgeInsets.all(4) : EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'locke.jpg',
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SwipeScreens extends StatefulWidget {
  @override
  State<SwipeScreens> createState() => _SwipeScreensState();
}

class _SwipeScreensState extends State<SwipeScreens> {
  bool _isDark = false;

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Widget build(BuildContext context) {
    final theme = _isDark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    return Theme(
      data: theme,
      child: PageView(
        children: [
          FadingTextAnimation(isDark: _isDark, onToggleTheme: _toggleTheme),
          SecondFadingTextAnimation(isDark: _isDark, onToggleTheme: _toggleTheme),
        ],
      ),
    );
  }
}
