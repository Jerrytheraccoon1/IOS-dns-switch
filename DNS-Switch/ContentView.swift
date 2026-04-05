import SwiftUI

struct ContentView: View {
    @State private var isDnsOn = false
    let backendIP = "77.90.13.115"
    let port = "5564"
    let authKey = "SUPER_SECRET_KEY"

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(isDnsOn ? .green : Color(white: 0.1))
                VStack(spacing: 15) {
                    Image(systemName: "power.circle.fill").font(.system(size: 80))
                    Text("DNS ON").font(.system(size: 45, weight: .black, design: .rounded))
                }
                .foregroundColor(isDnsOn ? .white : .gray)
            }
            .frame(maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture { sendToggle(state: "on") }

            Rectangle().fill(Color.black).frame(height: 20)

            ZStack {
                Color(!isDnsOn ? .red : Color(white: 0.1))
                VStack(spacing: 15) {
                    Image(systemName: "power.circle").font(.system(size: 80))
                    Text("DNS OFF").font(.system(size: 45, weight: .black, design: .rounded))
                }
                .foregroundColor(!isDnsOn ? .white : .gray)
            }
            .frame(maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture { sendToggle(state: "off") }
        }
        .ignoresSafeArea()
        .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.6), value: isDnsOn)
    }

    func sendToggle(state: String) {
        isDnsOn = (state == "on")
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        let url = URL(string: "http://\(backendIP):\(port)/toggle?state=\(state)&key=\(authKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request).resume()
    }
}
