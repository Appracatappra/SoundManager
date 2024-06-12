//
//  SoundManager.swift
//  SoundManager
//
//  Created by Kevin Mullins on 7/29/21.
//

import Foundation
import AVFoundation
import SwiftUI
import LogManager

/// Class to handle playing background music and sound effects throughout the game.
open class SoundManager: NSObject, AVAudioPlayerDelegate {
    public typealias FinishedPlaying = () -> Void
    
    // MARK: - Enumerations
    /// Defines which channel the sound effect will be played through.
    public enum SoundEffectChannel:Int {
        /// Effect all of the sound channels
        case all = -1
        
        /// Play through channel 1.
        case channel01 = 0
        
        /// Play through channel 2.
        case channel02 = 1
        
        /// Play through channel 3.
        case channel03 = 2
        
        /// Play through channel 4.
        case channel04 = 3
    }
    
    // MARK: - Static Properties
    /// Defines the common, shared instance of the Sound Manager
    static public nonisolated(unsafe) let shared:SoundManager = SoundManager()
    
    // MARK: - Properties
    /// Global variable that if `true`, background music will be played in the game.
    @AppStorage("playBackgroundMusic") public var shouldPlayBackgroundMusic: Bool = true
    
    /// Global variable that if `true`, background sounds will be played in the game.
    @AppStorage("playBackgroundSounds") public var shouldPlayBackgroundSounds: Bool = true
    
    /// Global variable that if `true`, sound effect will be played in the game.
    @AppStorage("playSoundEffects") public var shouldPlaySoundEffects: Bool = true
    
    /// The `AVAudioPlayer` used to play background music.
    public var backgroundMusic:AVAudioPlayer?
    
    /// The sound currently being played in the background music channel.
    public var currentBackgroundMusic:String = ""
    
    /// The `AVAudioPlayer` used to play room specific background sounds.
    public var backgroundSound:AVAudioPlayer?
    
    /// The background sound currently playing.
    public var currentBackgroundSound:String = ""
    
    /// The `AVAudioPlayer` used to play room specific background weather.
    public var backgroundWeather:AVAudioPlayer?
    
    /// The background sound currently playing.
    public var currentBackgroundWeather:String = ""
    
    /// Holds all of the available channels of sound effects.
    public var soundEffectChannels:[SoundManagerChannel] = []
    
    // MARK: - Initializers
    override init() {
        // Create all required sound channels.
        for _ in 1...4 {
            self.soundEffectChannels.append(SoundManagerChannel())
        }
    }
    
    // MARK: - Functions
    public func loadSoundResources() {
        //ODRManager.shared.prefetchResourceWith(tag: "Music01,BackgroundSounds01,Music02,BackgroundSounds02,Music03,Music04,BackgroundSounds03,Music05")
    }
    
    /// Starts playing the background music for the given audio file. If the sound is already playing, it will not be restarted. The sound provided will loop forever until `stopBackgroundMusic()` is called.
    /// - Parameter song: The sound (with extension) to be played.
    public func startBackgroundMusic(song:String) {
        
        guard shouldPlayBackgroundMusic else {
            return
        }
        
        // Is the song already playing?
        guard currentBackgroundMusic != song else {
            return
        }
        
        if let backgroundMusic {
            if backgroundMusic.isPlaying {
                stopBackgroundMusic()
            }
        }
        
        let path = Bundle.main.path(forResource: song, ofType:nil)
        if let path {
            let url = URL(fileURLWithPath: path)
            
            do {
                currentBackgroundMusic = song
                backgroundMusic = try AVAudioPlayer(contentsOf: url)
                backgroundMusic?.volume = 0.30
                backgroundMusic?.numberOfLoops = -1
                backgroundMusic?.play()
            } catch {
                Log.error(subsystem: "SoundManager", category: "startBackgroundMusic", "Unable to play background music: \(error)")
            }
        } else {
            Log.error(subsystem: "SoundManager", category: "startBackgroundMusic", "Unable find background music: \(song)")
        }
    }
    
    /// Starts playing the background music for the given audio file path. If the sound is already playing, it will not be restarted. The sound provided will loop forever until `stopBackgroundMusic()` is called.
    /// - Parameter path: The Bundle Resource Path to the audio file to play.
    public func startBackgroundMusic(path:String?) {
        
        guard shouldPlayBackgroundMusic else {
            return
        }
        
        guard let path else {
            return
        }
        
        // Is the song already playing?
        guard currentBackgroundMusic != path else {
            return
        }
        
        if let backgroundMusic {
            if backgroundMusic.isPlaying {
                stopBackgroundMusic()
            }
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            currentBackgroundMusic = path
            backgroundMusic = try AVAudioPlayer(contentsOf: url)
            backgroundMusic?.volume = 0.30
            backgroundMusic?.numberOfLoops = -1
            backgroundMusic?.play()
        } catch {
            Log.error(subsystem: "SoundManager", category: "startBackgroundMusic", "Unable to play background music: \(error)")
        }
    }
    
    /// This is the room specific background music. The sound provided will loop forever until `stopBackgroundSound()` is called.
    /// - Parameter sound: The sound (with extension) to be played.
    public func playBackgroundSound(sound:String) {
        
        guard shouldPlayBackgroundSounds else {
            return
        }
        
        guard currentBackgroundSound != sound else {
            return
        }
        
        if let backgroundSound {
            if backgroundSound.isPlaying {
                stopBackgroundSound()
            }
        }
        
        let path = Bundle.main.path(forResource: sound, ofType:nil)
        if let path {
            let url = URL(fileURLWithPath: path)
            
            do {
                currentBackgroundSound = sound
                backgroundSound = try AVAudioPlayer(contentsOf: url)
                backgroundSound?.volume = 0.30
                backgroundSound?.numberOfLoops = -1
                backgroundSound?.play()
            } catch {
                Log.error(subsystem: "SoundManager", category: "playBackgroundSound", "Unable to play background music: \(error)")
            }
        } else {
            Log.error(subsystem: "SoundManager", category: "playBackgroundSound", "Unable find background music: \(sound)")
        }
    }
    
    /// This is the room specific background music. The sound provided will loop forever until `stopBackgroundSound()` is called.
    /// - Parameter path: The Bundle Resource Path to the audio file to play.
    public func playBackgroundSound(path:String?) {
        
        guard shouldPlayBackgroundSounds else {
            return
        }
        
        guard let path else {
            return
        }
        
        guard currentBackgroundSound != path else {
            return
        }
        
        if let backgroundSound {
            if backgroundSound.isPlaying {
                stopBackgroundSound()
            }
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            currentBackgroundSound = path
            backgroundSound = try AVAudioPlayer(contentsOf: url)
            backgroundSound?.volume = 0.30
            backgroundSound?.numberOfLoops = -1
            backgroundSound?.play()
        } catch {
            Log.error(subsystem: "SoundManager", category: "playBackgroundSound", "Unable to play background music: \(error)")
        }
    }
    
    /// This is the room specific background weather sound. The sound provided will loop forever until `stopBackgroundWeather()` is called.
    /// - Parameter sound: The sound (with extension) to be played.
    public func playBackgroundWeather(sound:String) {
        
        guard shouldPlayBackgroundSounds else {
            return
        }
        
        guard currentBackgroundWeather != sound else {
            return
        }
        
        if let backgroundWeather {
            if backgroundWeather.isPlaying {
                stopBackgroundWeather()
            }
        }
        
        let path = Bundle.main.path(forResource: sound, ofType:nil)
        if let path {
            let url = URL(fileURLWithPath: path)
            
            do {
                currentBackgroundWeather = sound
                backgroundWeather = try AVAudioPlayer(contentsOf: url)
                backgroundWeather?.volume = 0.30
                backgroundWeather?.numberOfLoops = -1
                backgroundWeather?.play()
            } catch {
                Log.error(subsystem: "SoundManager", category: "playBackgroundWeather", "Unable to play background weather: \(error)")
            }
        } else {
            Log.error(subsystem: "SoundManager", category: "playBackgroundWeather", "Unable find background weather: \(sound)")
        }
    }
    
    /// This is the room specific background weather sound. The sound provided will loop forever until `stopBackgroundWeather()` is called.
    /// - Parameter path: The Bundle Resource Path to the audio file to play.
    public func playBackgroundWeather(path:String?) {
        
        guard shouldPlayBackgroundSounds else {
            return
        }
        
        guard let path else {
            return
        }
        
        guard currentBackgroundWeather != path else {
            return
        }
        
        if let backgroundWeather {
            if backgroundWeather.isPlaying {
                stopBackgroundWeather()
            }
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            currentBackgroundWeather = path
            backgroundWeather = try AVAudioPlayer(contentsOf: url)
            backgroundWeather?.volume = 0.30
            backgroundWeather?.numberOfLoops = -1
            backgroundWeather?.play()
        } catch {
            Log.error(subsystem: "SoundManager", category: "playBackgroundWeather", "Unable to play background weather: \(error)")
        }
    }
    
    /// Stops the currently playing background music.
    public func stopBackgroundMusic() {
        
        backgroundMusic?.stop()
        currentBackgroundMusic = ""
        backgroundMusic = nil
    }
    
    /// Stops the currently playing room specific background sound.
    public func stopBackgroundSound() {
        
        backgroundSound?.stop()
        currentBackgroundSound = ""
        backgroundSound = nil
    }
    
    /// Stops the currently playing room specific background weather.
    public func stopBackgroundWeather() {
        
        backgroundWeather?.stop()
        currentBackgroundWeather = ""
        backgroundWeather = nil
    }
    
    /// Stops sound effects playing on the given channel.
    /// - Parameter channel: The channel to stop sound effects on.
    public func stopSoundEffect(channel:SoundEffectChannel = .channel01) {
        switch(channel) {
        case .all:
            for sound in soundEffectChannels {
                sound.soundEffect?.stop()
                sound.soundEffect = nil
            }
        default:
            let n = channel.rawValue
            soundEffectChannels[n].soundEffect?.stop()
            soundEffectChannels[n].soundEffect = nil
        }
    }
    
    /// Plays the given sound effect on the given effect channel.
    /// - Parameters:
    ///   - sound: The sound (with extension) to be played.
    ///   - channel: The effect channel to play the song on. The default is `channel01`.
    ///   - didFinishPlaying: The closure that will be called when the sound finishes playing.
    public func playSoundEffect(sound:String, channel:SoundEffectChannel = .channel01, didFinishPlaying:FinishedPlaying? = nil) {
        
        guard shouldPlaySoundEffects else {
            if let didFinishPlaying {
                didFinishPlaying()
            }
            return
        }
        
        guard channel != .all else {
            if let didFinishPlaying {
                didFinishPlaying()
            }
            return
        }
        
        let path = Bundle.main.path(forResource: sound, ofType:nil)
        if let path = path {
            let url = URL(fileURLWithPath: path)
            
            do {
                let n = channel.rawValue
                soundEffectChannels[n].soundEffectDelegate = SoundManagerDelegate(action: didFinishPlaying)
                soundEffectChannels[n].soundEffect = try AVAudioPlayer(contentsOf: url)
                soundEffectChannels[n].soundEffect?.delegate = soundEffectChannels[n].soundEffectDelegate
                soundEffectChannels[n].soundEffect?.play()
            } catch {
                Log.error(subsystem: "SoundManager", category: "playSoundEffect", "Unable to play sound effect: \(error)")
            }
        } else {
            Log.error(subsystem: "SoundManager", category: "playSoundEffect", "Unable find sound effect: \(sound)")
        }
    }
    
    /// Plays the given sound effect on the given effect channel.
    /// - Parameters:
    ///   - path: The Bundle Resource Path to the audio file to play.
    ///   - channel: The effect channel to play the song on. The default is `channel01`.
    ///   - didFinishPlaying: The closure that will be called when the sound finishes playing.
    public func playSoundEffect(path:String?, channel:SoundEffectChannel = .channel01, didFinishPlaying:FinishedPlaying? = nil) {
        
        guard shouldPlaySoundEffects else {
            if let didFinishPlaying = didFinishPlaying {
                didFinishPlaying()
            }
            return
        }
        
        guard channel != .all else {
            if let didFinishPlaying = didFinishPlaying {
                didFinishPlaying()
            }
            return
        }
        
        guard let path else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let n = channel.rawValue
            soundEffectChannels[n].soundEffectDelegate = SoundManagerDelegate(action: didFinishPlaying)
            soundEffectChannels[n].soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffectChannels[n].soundEffect?.delegate = soundEffectChannels[n].soundEffectDelegate
            soundEffectChannels[n].soundEffect?.play()
        } catch {
            Log.error(subsystem: "SoundManager", category: "playSoundEffect", "Unable to play sound effect: \(error)")
        }
    }
}

/// Holds the instance of a sound channel.
open class SoundManagerChannel: NSObject {
    
    // MARK: - Properties
    /// The `AVAudioPlayer` used to play a channel of sound effects.
    public var soundEffect:AVAudioPlayer?
    
    /// The delegate used to handle events on the given channel of sound effects.
    public var soundEffectDelegate:SoundManagerDelegate? = nil
    
    // MARK: - Initializers
    /// Creates a new instace
    /// - Parameters:
    ///   - soundEffect: The `AVAudioPlayer` playing the effect.
    ///   - soundEffectDelegate: The `SoundManagerDelegate` to attach to the effect.
    public init(soundEffect: AVAudioPlayer? = nil, soundEffectDelegate: SoundManagerDelegate? = nil) {
        self.soundEffect = soundEffect
        self.soundEffectDelegate = soundEffectDelegate
    }
}

/// Delegate that handles a sound finishing playing on one of the sound effect channels.
open class SoundManagerDelegate: NSObject, AVAudioPlayerDelegate {
    public typealias FinishedPlaying = () -> Void
    
    // MARK: - Properties
    /// The closure that gets called when the sound finishes playing.
    public var finishPlaying:FinishedPlaying? = nil
    
    // MARK: - Initializers
    /// Creates a new instance of the object with the given parameters.
    /// - Parameter action: The closure that gets called when the sound finishes playing.
    public init(action:FinishedPlaying?) {
        // Initialize
        self.finishPlaying = action
    }
    
    // MARK: - Functions
    /// Function called when the sound finishes playing
    /// - Parameters:
    ///   - player: The `AVAudioPlayer` that was playing the sound.
    ///   - flag: If `true`, the sound played successfully.
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let finishPlaying = finishPlaying {
            finishPlaying()
        }
    }
}
