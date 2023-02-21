# GlitchEffect

A Flutter widget that will give a Glitch Animation Effect to it's child widget.

## Preview
![alt-text](https://raw.githubusercontent.com/sameersingh2704/glitcheffect/main/assets/gif/glitch.gif)

## Example

```dart
import 'package:flutter/material.dart';
import 'package:glitcheffect/glitcheffect.dart';

class GlitchEffectExample extends StatelessWidget {
  const GlitchEffectExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlitchEffect(
      child: Text(
        'Flutter',
        style: TextStyle(fontSize: 30, color: Colors.red),
      ),
    );
  }
}
```

## Customisation

### GlitchEffect

#### Parameters

| Name | Type | Description | Required? |
|:-----|:-----|:-----|:---------:|
| `controller` | [GlitchController](/lib/src/glitch_controller.dart) | Customise the glitch effect. |    [ ]    | 
| `child` | Widget | on which you want a glitch effect. |    [x]    |

### GlitchController

#### Parameters

| Name | Type | Description | Default value |
|:-----|:-----|:-----|:-----|
| `isRepeating` | bool | Whether the glitch effect should play once or play over and over. | `true` |
| `isStartingOnInitState` | bool | Whether the glitch effect should start when widget gets rendered. | `true` |
| `duration` | Duration | How long the glitch effect should be. | `Duration(milliseconds: 400)` |
| `pauseDuration` | Duration | How long it should take until the glitch effect repeats itself. If `isRepeating` is false, this will only have effect once. | `Duration(seconds: 3)` |
| `colors` | List<Color> | List of colors that you want to use for glitch effect | `[Colors.white, Colors.grey, Colors.black]` |

#### Methods

| Name | Type | Description |
|:-----|:-----:|:-----|
| `forward()` | void | Creates the glitch effect once. |
| `reset()` | void | Resets the glitch effect. |
| `start()` | void | Starts the glitch effect in a loop based on `isRepeating`. |
| `stop()` | void | Stops the loop of `start()`. |

## Contributors
* [**Sameer Singh**](https://github.com/sameersingh2704)
* [**Juliotati**](https://github.com/Juliotati)