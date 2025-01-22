import SwiftUI
import AVFAudio
import Combine

class AudioManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    private var fadeTimer: Timer?
    
    init() {
        if let soundURL = Bundle.main.url(forResource: "rain", withExtension: "mp3") {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                self.audioPlayer?.numberOfLoops = -1 // Бесконечное воспроизведение
                self.audioPlayer?.prepareToPlay()
            } catch {
                print("Ошибка загрузки звука: \(error.localizedDescription)")
            }
        }
    }
    
    func play() {
        audioPlayer?.volume = 1.0
        audioPlayer?.play()
    }
    
    func playWithFade(duration: TimeInterval = 2.0) {
            guard let audioPlayer = audioPlayer else { return }

            audioPlayer.volume = 0.0 // Устанавливаем начальную громкость
            audioPlayer.play()

            fadeTimer?.invalidate() // Останавливаем предыдущий таймер
            let fadeStep = 1.0 / Float(duration * 10) // Шаг увеличения громкости

            fadeTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                guard let self = self, let audioPlayer = self.audioPlayer else {
                    timer.invalidate()
                    return
                }

                if audioPlayer.volume < 1.0 {
                    audioPlayer.volume += fadeStep
                } else {
                    timer.invalidate()
                }
            }
        }
    
    func pauseWithFade(duration: TimeInterval = 2.0) {
            guard let audioPlayer = audioPlayer else { return }

            fadeTimer?.invalidate() // Останавливаем предыдущий таймер
            let fadeStep = audioPlayer.volume / Float(duration * 10) // Шаг уменьшения громкости

            fadeTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                guard let self = self, let audioPlayer = self.audioPlayer else {
                    timer.invalidate()
                    return
                }

                if audioPlayer.volume > 0 {
                    audioPlayer.volume -= fadeStep
                } else {
                    timer.invalidate()
                    audioPlayer.pause() // Ставим воспроизведение на паузу
                }
            }
        }
}

