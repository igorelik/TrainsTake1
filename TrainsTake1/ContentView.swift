//
//  ContentView.swift
//  TrainsTake1
//
//  Created by Igor Gorelik on 22/8/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindow


    var body: some View {
        HStack {
            Button {
                openWindow(id: "report")
            } label: {
                Image("SydneyRailMap")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            Image("CCTV")
                .resizable()
                .aspectRatio(contentMode: .fit)

//             VStack {
////                Model3D(named: "Scene", bundle: realityKitContentBundle)
////                    .padding(.bottom, 50)
//                
//                
//                Text("Hello, world!")
//                
////                Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
////                    .toggleStyle(.button)
////                    .padding(.top, 50)
////                
//                Button(action: {
//                    openWindow(id: "zoom-in")
//                }, label: {
//                    Text("Zoom Into the disruption")
//                })
//            }
        }
   //     .background(.red)

  //      .background(Image("SydneyRailMap"))
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
//        .onAppear(){
//            openWindow(id: "cctv")
//        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
