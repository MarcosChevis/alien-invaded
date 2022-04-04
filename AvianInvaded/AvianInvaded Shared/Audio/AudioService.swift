//
//  AudioService.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 03/04/22.
//

import AVFoundation

enum Music: String {
    case main = "AvianInvasionTheme.mp3"
}

protocol AudioServiceProtocol {
    func play(music: Music)
    func stop(music: Music)
}

final class AudioService: AudioServiceProtocol {
    private var cachedSoundPlayer: [Music: AVAudioPlayer] = [:]
    
    func play(music: Music) {
        guard
            let path = Bundle.main.path(forResource: music.rawValue, ofType: nil)
        else { return }
        let url = URL(fileURLWithPath: path)
        
        if let previousAudio = cachedSoundPlayer[music], previousAudio.isPlaying {
            return
        }

        do {
            let audio = try AVAudioPlayer(contentsOf: url)
            audio.volume = 0.7
            audio.numberOfLoops = -1
            audio.play()
            cachedSoundPlayer[music] = audio
        } catch {
            // couldn't load file :(
        }
    }
    
    func stop(music: Music) {
        guard let audio = cachedSoundPlayer[music] else { return }
        audio.stop()
        cachedSoundPlayer[music] = nil
    }
}
