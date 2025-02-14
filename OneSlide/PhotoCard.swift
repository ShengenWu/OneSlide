import SwiftUI

struct PhotoCard: View {
    let photo: Photo
    
    var body: some View {
        Image(photo.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 400)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
} 