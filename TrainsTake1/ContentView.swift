//
//  ContentView.swift
//  TrainsTake1
//
//  Created by Igor Gorelik on 22/8/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent
import AVKit

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    
    @State var displayVideoPlayback = false
    @State var player =  AVPlayer()

    var body: some View {
        ZStack {
            HStack {
                VStack {
//                    Button {
//                        openWindow(id: "report")
//                    } label: {
//                        Image("SydneyRailMap")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(.plain)
                    Button {
                        openWindow(id: "report")
                    } label: {
                        Image("rail_map")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 20)
                    
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
                }
//                Button {
//                    Task { @MainActor in
//                        displayVideoPlayback.toggle()
//                    }
//                } label: {
//                    Image("CCTV")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                }
            }
            .task {
                openWindow(id: "trainMap")
            }
            
            if displayVideoPlayback {
                Button {
                    Task { @MainActor in
                        player.pause()
                        displayVideoPlayback.toggle()
                    }
                } label: {
                    VStack {
                        LegacyVideoPlayer(player: player)
//                            .frame(maxWidth: 783)
                            .onAppear{
                                if player.currentItem == nil {
                                            let item = AVPlayerItem(url: Bundle.main.url(forResource: "cctvFeed", withExtension: "mp4")!)
                                            player.replaceCurrentItem(with: item)
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                            player.seek(to: CMTime(value:6, timescale: 1))
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

#Preview(windowStyle: .automatic) {
    ContentView()
}
