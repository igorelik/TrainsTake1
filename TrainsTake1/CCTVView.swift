//
//  CCTVView.swift
//  TrainsTake1
//
//  Created by Igor Gorelik on 23/8/2023.
//

import SwiftUI
import AVFoundation
import AVKit

struct CCTVView: View {
    @State var displayVideoPlayback = false
    @State var player =  AVPlayer()

    var body: some View {
        ZStack {
            Button {
                Task { @MainActor in
                    displayVideoPlayback.toggle()
                }
            } label: {
                Image("CCTV")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .buttonStyle(.plain)
            if displayVideoPlayback {
                Button {
                    Task { @MainActor in
                        player.pause()
                        displayVideoPlayback.toggle()
                    }
                } label: {
                    VStack {
                        VideoPlayer(player: player)
                            .onAppear{
                                if player.currentItem == nil {
                                    let item = AVPlayerItem(url: Bundle.main.url(forResource: "cctvFeed", withExtension: "mp4")!)
                                    player.replaceCurrentItem(with: item)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                    player.play()
                                })
                            }
                            .padding(50)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    CCTVView()
}
