//
//  ContentView.swift
//  HeartBeat
//
//  Created by Qin Chingis on 1/19/25.
//
import AVFoundation
import SwiftUI

struct HeartBeat2D: View {
    @State private var position: CGSize = .zero // Позиция объекта
    @State private var dragOffset: CGSize = .zero // Смещение во время жеста
    @State private var isAnimating = false
    @StateObject private var audioManager = AudioManager()
    var body: some View {

            ZStack {
                RainEffectView()
                HeartBeatView()
                    .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height) // Позиция объекта
                    .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            // Обновляем временное смещение
                                            audioManager.pauseWithFade()
                                            dragOffset = gesture.translation
                                        }
                                        .onEnded { _ in
                                            withAnimation(.spring()) {
                                                dragOffset = .zero
                                                audioManager.playWithFade()
                                            }
                                        }
                                )
                
                                .animation(.easeInOut, value: position)
            }
            .onAppear {
                audioManager.play()            }
        }
    
    
}

#Preview {
    HeartBeat2D()
}
