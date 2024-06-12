# Sound Manager

![](https://img.shields.io/badge/license-MIT-green) ![](https://img.shields.io/badge/maintained%3F-Yes-green) ![](https://img.shields.io/badge/swift-6.0-green) ![](https://img.shields.io/badge/iOS-18.0-red) ![](https://img.shields.io/badge/macOS-15.0-red) ![](https://img.shields.io/badge/tvOS-18.0-red) ![](https://img.shields.io/badge/watchOS-11.0-red) ![](https://img.shields.io/badge/dependency-LogManager-orange)

`SoundManager` provides a simply way to play sounds in an App.

## Support

If you find `SoundManager` useful and would like to help support its continued development and maintenance, please consider making a small donation, especially if you are using it in a commercial product:

<a href="https://www.buymeacoffee.com/KevinAtAppra" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

It's through the support of contributors like yourself, I can continue to build, release and maintain high-quality, well documented Swift Packages like `SoundManager` for free.

## Installation

**Swift Package Manager** (Xcode 11 and above)

1. In Xcode, select the **File** > **Add Package Dependency…** menu item.
2. Paste `https://github.com/Appracatappra/SoundManager.git` in the dialog box.
3. Follow the Xcode's instruction to complete the installation.

> Why not CocoaPods, or Carthage, or etc?

Supporting multiple dependency managers makes maintaining a library exponentially more complicated and time consuming.

Since, the **Swift Package Manager** is integrated with Xcode 11 (and greater), it's the easiest choice to support going further.

## Overview

`SoundManager` provides a simply way to play sounds in an App in different channels and having different channels for background music and background effects.

### User Preference Options

`SoundManager` has three build in User Preference properties to control sound:

```
/// Global variable that if `true`, background music will be played in the game.
@AppStorage("playBackgroundMusic") public var shouldPlayBackgroundMusic: Bool = true
    
/// Global variable that if `true`, background sounds will be played in the game.
@AppStorage("playBackgroundSounds") public var shouldPlayBackgroundSounds: Bool = true
    
/// Global variable that if `true`, sound effect will be played in the game.
@AppStorage("playSoundEffects") public var shouldPlaySoundEffects: Bool = true
```

You can provide a UI in your App to allow the end user to control their sound preferences.

### How To Use

`SoundManager` provides several functions for easily playing music or sounds on different channels. The most commonly user are:

* **startBackgroundMusic** - `public func startBackgroundMusic(song:String)` Starts playing the given sound as background music on infinite loop.
* **playBackgroundSound** - `public func playBackgroundSound(sound:String)` Starts playing the given sound as a background sounds on infinite loop.
* **stopBackgroundMusic** - `public func stopBackgroundMusic()` Stops the currently playing background music.
* **stopBackgroundSound** - `public func stopBackgroundSound()` Stops the currently playing background sound.
* **playSoundEffect** - `public func playSoundEffect(sound:String, channel:SoundEffectChannel = .channel01, didFinishPlaying:FinishedPlaying? = nil)` Plays the given sound effect on the given channel. If provided a callback handler, you'll be informed when the sounds stops playing.
* **stopSoundEffect** - `public func stopSoundEffect(channel:SoundEffectChannel = .channel01)` Stops playing the sound effect on the given channel.

> **NOTE:** Include any **Music** or **Sound** file in your App's Bundle. When calling a method in the `SoundManager` include the extension of the sound file as well, for example: `MySound.mp3`. Also note that sounds are case sensitive.

# Documentation

The **Package** includes full **DocC Documentation** for all features.
