//
//  ContentView.swift
//  Instafilter
//
//  Created by Amier Davis on 2/23/26.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    @Environment(\.requestReview) var requestReview
    
    let example = Image(.example)
    
    var body: some View {
        VStack {
            VStack {
                PhotosPicker("Select a picture", selection: $pickerItems, maxSelectionCount: 3, matching: .images)
                ScrollView {
                    ForEach(0..<selectedImages.count, id: \.self) { i in
                        selectedImages[i]
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .onChange(of: pickerItems) {
                Task {
                    selectedImages.removeAll()
                    
                    for  item in pickerItems {
                        if let loadedImage = try await item.loadTransferable(type: Image.self) {
                            selectedImages.append(loadedImage)
                        }
                    }
                }
            }
            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
                Label("Learn more about Swift", systemImage: "swift")
            }
            ShareLink(item: example, preview: SharePreview("Cartman", image: example)) {
                Label("Share Cartman", systemImage: "square.and.arrow.up")
            }
            image?
                .resizable()
                .scaledToFit()
            ContentUnavailableView(
                "No snippets",
                systemImage: "swift",
                description: Text("You don't have any saved snippets yet.")
            )
        }
        .onAppear(perform: loadImage)
        .onAppear {
            requestReview()
        }
    }
    
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage
        
        let amount = 0.4
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
