import SwiftUI

struct ReportView: View {
	@Environment(\.openWindow) private var openWindow
    var body: some View {
        ZStack{
            Image("Report")
                .resizable()
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
						openWindow(id: "face-time")
					}){
                        Text("Call Police")
                            .padding(.horizontal, 80)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(50)
                    
                }
            }
        }
    }
}

#Preview {
    ReportView()
}
