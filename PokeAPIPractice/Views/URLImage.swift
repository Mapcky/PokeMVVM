//
//  URLImage.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import SwiftUI

struct URLImage: View {
    
    let url: String
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(url: String) {
        self.url = url
        self.imageLoader.downloadImage(url: self.url)
    }
    
    var body: some View {
        if let data = self.imageLoader.downloadedData {
            Image(uiImage: UIImage(data: data)!)
                .resizable()
                .scaledToFit() // Aplica scaleToFit
        } else {
            Image("pokeball")
                .resizable()
                .frame(width: 40, height: 40) // Aplica scaleToFit también al placeholder
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "https://fyrafix.files.wordpress.com/2011/08/url-8.jpg")
    }
}
