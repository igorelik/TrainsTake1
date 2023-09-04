//
//  FacetimeCallView.swift
//  TrainsTake1
//
//  Created by karmjit singh on 23/8/2023.
//

import SwiftUI
import AVKit

struct FacetimeCallView: View {
	let vidPlayer = AVPlayer(url: Bundle.main.url(forResource: "video2", withExtension: "mp4")!)
	var body: some View {
		
		VStack {
            LegacyVideoPlayer(player: vidPlayer)
                .onAppear {
                    vidPlayer.play()
                }
                .frame(width: 500, height: 280)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
			
			Image("facetime-controls")
				.resizable()
                .frame(width: 500, height: 200)
				.aspectRatio(contentMode: .fit)
				
			
		}
//		.frame(maxWidth: 500)
//		.fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FacetimeCallView()
}
