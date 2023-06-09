//
//  ResultView.swift
//  ToadBakeryARPastryQuiz
//
//  Created by Sophie Yau on 24/04/2023.
//

import SwiftUI
import ARKit
import RealityKit

struct ResultView: View {
    let userName: String
    let pastry: Pastry
    @EnvironmentObject var quizManager: QuizManager
    
    @State var showARView: Bool = false
    @Binding var presentationMode: PresentationMode
    
    var id: Int {
        quizManager.finalResult.id
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Spacer()
            Text("You are the \(pastry.name)!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Image(pastry.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(pastry.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .frame(width: 350)
            
            Spacer()
            
            HStack(spacing: 16) {
                ToadButton(action: {
                    quizManager.resetQuiz()
                    presentationMode.dismiss()
                }, label: "Restart the quiz")
                
                ToadButton(action: {
                    self.showARView = true
                }, label: "See me in AR")
                .sheet(isPresented: $showARView, onDismiss: {
                    self.showARView = false
                }) {
                    ARSceneView(pastryId: self.id, presentationMode: $presentationMode) // Passing the presentationMode as a binding
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .padding(.bottom, 50)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
    }
}
struct ARSceneView: View {
    var pastryId: Int
    @Binding var presentationMode: PresentationMode

    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(pastryId: pastryId)

            VStack {
                Spacer()
                
                Button(action: {
                    // Call function to take a snapshot
                    takeSnapshot()
                }) {
                    Image("toadshutterbutton")
                        .resizable()
                        .frame(width: 120, height: 120)
                }
                .padding(.bottom, 20)
            }
        }
    }
}


    func takeSnapshot() {
        if let arView = ARViewContainer.arView {
            arView.snapshot(saveToHDR: false) { (image) in
                if let snapshotImage = image {
                    let compressedImage = UIImage(data: snapshotImage.pngData()!)
                    UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                }
            }
        }
    }

struct ARViewContainer: UIViewRepresentable {
    static var arView: ARView?
    
    var pastryId: Int
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        ARViewContainer.arView = arView
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        uiView.scene.anchors.removeAll()
        
        DispatchQueue.global(qos: .background).async {
            let arConfiguration = ARFaceTrackingConfiguration()
            uiView.session.run(arConfiguration, options: [.resetTracking, .removeExistingAnchors])
            
            DispatchQueue.main.async {
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
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
