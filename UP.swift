import SwiftUI

struct ContentView: View {
    @State private var selectedImageIndex: Int?
    @State private var isAlertPresented = false
    @State private var isMenuOpen = false
    
    let imageInfo = [
        (imageName: "AnimeMeek", info: "From the animated film 'Digital Love 2'"),
        (imageName: "NewSet", info: "Info for NewSet"),
        (imageName: "IdcPic", info: "Info for IdcPic"),
        (imageName: "Pyramids", info: "Info for Pyramids"),
        (imageName: "DmdPic", info: "Info for DmdPic")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AngularGradient(gradient: Gradient(colors: [.gray, .white]), center: .center, startAngle: .degrees(0), endAngle: .degrees(360))
                    .rotationEffect(.degrees(30))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all) // Fix to fill the entire screen
                    .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false))
                    .blur(radius: 4)
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Toggle the menu
                            self.isMenuOpen.toggle()
                        }) {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.primary)
                                .contextMenu {
                                    NavigationLink(destination: HomeView()) {
                                        Text("Home")
                                    }
                                    NavigationLink(destination: ContactView()) {
                                        Text("Contact")
                                    }
                                    NavigationLink(destination: InformationView()) {
                                        Text("Information")
                                    }
                                }
                        }
                    }
                    
                    Text("UP ANIMATIONS")
                        .foregroundColor(.cyan)
                        .font(.largeTitle)
                        .bold()
                        .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                        .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        Divider()
                        HStack(spacing: 20) {
                            ForEach(0..<imageInfo.count, id: \.self) { index in
                                let imageInfoItem = imageInfo[index]
                                VStack(alignment: .leading, spacing: 19) {
                                    Button(action: {
                                        // Handle button action here
                                        self.selectedImageIndex = index
                                        self.isAlertPresented = true // Show the alert
                                    }) {
                                        Image(imageInfoItem.imageName) // Use imageInfoItem
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 350, height: 350)
                                            .cornerRadius(10)
                                            .opacity(self.selectedImageIndex == index ? 0.5 : 1.0)
                                            .padding(.horizontal, 10)
                                            .shadow(color: .black, radius: 4, x: 0.0, y: 0.0)
                                    }
                                    .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.bottom, 20)
                        }
                    }
                    Divider()
                    
                }
                .alert(isPresented: $isAlertPresented) {
                    Alert(
                        title: Text("Info"), // Wrap in Text
                        message: Text(imageInfo[selectedImageIndex ?? 0].info), // Wrap in Text, and use imageInfo
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
