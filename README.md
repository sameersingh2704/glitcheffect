<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Hoverover

A Flutter widget that will give a Glitch Animation Effect to it's child widget.

## Installation 

1. Add the latest version of package to your pubspec.yaml (and run`dart pub get`):
```yaml
dependencies:
  glitcheffect: ^1.0.0
```
2. Import the package and use it in your Flutter App.
```dart
import 'package:glitcheffect/glitcheffect.dart';
```


3. There are a number of properties that you can modify:

* *child* : Widget on which you want glitch effect.
* *onlyFirstTime* : if you want this animation once *[default value is false]*.
* *duration* : Duration after which you want the animation to repeat itself *[default value is 3 seconds]*.
* *colors* : List of colors that you want to use for glitch effect *[default colors are Black, Grey and White]*.

### Preview
![alt-text](assets/gif/glitch.gif)

<hr>

<table>
<tr>
<td>
## Example

```dart
class GlitchEffectExample extends StatelessWidget {
  const GlitchEffectExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlithEffect(
                child: Text(
                  'Flutter',
                  style: TextStyle(fontSize: 30, color: Colors.red),
                ),
              );
  }
}

```



## Contributors
* [**Sameer Singh**](https://github.com/sameersingh2704)
