import SwiftUI

struct ReportView: View {
    var body: some View {
        ZStack{
            Image("Report")
                .resizable()
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {}){
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
