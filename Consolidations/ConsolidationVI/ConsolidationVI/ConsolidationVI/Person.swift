//
//  Person.swift
//  ConsolidationVI
//
//  Created by Amier Davis on 5/24/26.
//

import SwiftData
import SwiftUI

@Model
class Person: Identifiable {
    var id: UUID
    var name: String
    @Attribute(.externalStorage) private var imageData: Data?
    
    var image: Image? {
        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        
        return nil
    }
    
    init(name: String, uiImage: UIImage) {
        id = UUID()
        self.name = name
        self.imageData = uiImage.pngData()
    }
}
