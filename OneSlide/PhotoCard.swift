import SwiftUI
import PhotosUI

struct PhotoCard: View {
    let photo: Photo
    @State private var image: UIImage? = nil
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 400)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            } else {
                ProgressView()
                    .frame(width: 300, height: 400)
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.deliveryMode = .highQualityFormat
        
        manager.requestImage(for: photo.asset,
                            targetSize: CGSize(width: 600, height: 600),
                            contentMode: .aspectFill,
                            options: options) { (result, _) in
            self.image = result
        }
    }
} 