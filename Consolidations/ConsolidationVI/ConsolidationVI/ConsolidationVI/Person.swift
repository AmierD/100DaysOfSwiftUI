//
//  Person.swift
//  ConsolidationVI
//
//  Created by Amier Davis on 5/24/26.
//

import CoreLocation
import SwiftData
import SwiftUI

@Model
class Person: Identifiable {
    var id: UUID
    var name: String
    @Attribute(.externalStorage) private var imageData: Data?
    var latitude: Double?
    var longitude: Double?
    
    var image: Image? {
        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        
        return nil
    }
    
    init(name: String, uiImage: UIImage, location: CLLocationCoordinate2D? = nil) {
        id = UUID()
        self.name = name
        self.imageData = uiImage.pngData()
        self.latitude = location?.latitude
        self.longitude = location?.longitude
    }
}
