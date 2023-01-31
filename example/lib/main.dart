import 'package:flutter/material.dart';
import 'package:glitcheffect/glitcheffect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String _title = 'Glitch effect demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlitchController _glitchController = GlitchController(
    isStartingOnInitState: false,
  );

  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 350),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const GlitchEffect(
                child: Text('default'),
              ),
              const Divider(),
              GlitchEffect(
                controller: GlitchController(
                  colors: [Colors.red, Colors.green, Colors.blue],
                ),
                child: const Text('custom colors'),
              ),
              const Divider(),
              GlitchEffect(
                controller: GlitchController(isRepeating: false),
                child: const Text('is not repeating'),
              ),
              const Divider(),
              GlitchEffect(
                controller: _glitchController,
                child: const Text(
                  'is not starting on initState',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Tooltip(
                  message: _isRunning ? 'Stop' : 'Start',
                  child: IconButton(
                    onPressed: () {
                      _isRunning
                          ? _glitchController.stop()
                          : _glitchController.start();
                      setState(() => _isRunning = !_isRunning);
                    },
                    icon: Icon(
                      _isRunning ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
