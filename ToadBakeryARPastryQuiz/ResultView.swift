//
//  ResultView.swift
//  ToadBakeryARPastryQuiz
//
//  Created by Sophie Yau on 24/04/2023.
//

import SwiftUI
import ARKit
import RealityKit

var arView: ARView!

struct ResultView: View {
    let userName: String
    let pastry: Pastry
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var quizManager: QuizManager

    @State var showARView: Bool = false
    
    var id: Int {
        quizManager.finalResult.id
    }
    
    var body: some View {
        VStack {
            Text("\(userName), You are the \(pastry.name)!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            Image(pastry.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Text(pastry.description)
                .padding()

            Button(action: {
                quizManager.resetQuiz() // Reset the quiz
                presentationMode.wrappedValue.dismiss() // Go back to the previous view
            }) {
                Text("Restart the quiz")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: {
                self.showARView = true
            }) {
                Text("See me in AR")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showARView, onDismiss: {
                self.showARView = false
            }) {
                ARSceneView(pastryId: self.id)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .padding()
    }
}

struct ARSceneView: View {
    var pastryId: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(pastryId: pastryId)
            
            HStack {
                Spacer()
                
                Button(action: {
                    // Call your function to take a snapshot
                    takeSnapshot()
                }) {
                    Image("toadshutterbutton")
                        .resizable()
                        .frame(width: 120, height: 120)
                }
                
                Spacer()
            }
        }
    }
    
    func takeSnapshot() {
        arView.snapshot(saveToHDR: false) { (image) in
            let compressedImage = UIImage(data: (image?.pngData())!)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    var pastryId: Int
    
    func makeUIView(context: Context) -> ARView {
        arView = ARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        arView.scene.anchors.removeAll()
        
        let arConfiguration = ARFaceTrackingConfiguration()
        uiView.session.run(arConfiguration, options:[.resetTracking, .removeExistingAnchors])
        
        switch(pastryId) {
        case 0:
            let arAnchor = try! PastryARExperience.loadCheesypuff()
            uiView.scene.anchors.append(arAnchor)
            break
        case 1:
            let arAnchor = try! PastryARExperience.loadSoysaucechoco()
            uiView.scene.anchors.append(arAnchor)
            break
        case 2:
            let arAnchor = try! PastryARExperience.loadYuzualmond()
            uiView.scene.anchors.append(arAnchor)
            break
        case 3:
            let arAnchor = try! PastryARExperience.loadRhubarbpandan()
            uiView.scene.anchors.append(arAnchor)
            break
        case 4:
            let arAnchor = try! PastryARExperience.loadMambowsteak()
            uiView.scene.anchors.append(arAnchor)
            break
        default:
            break
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
