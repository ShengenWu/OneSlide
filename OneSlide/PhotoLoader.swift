import Photos

class PhotoLoader: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var hasPermission: Bool = false
    
    init() {
        requestPermission()
    }
    
    private func requestPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                self.hasPermission = status == .authorized
                if self.hasPermission {
                    self.fetchPhotos()
                }
            }
        }
    }
    
    private func fetchPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        fetchResult.enumerateObjects { (asset, _, _) in
            self.photos.append(Photo(asset: asset))
        }
    }
} 