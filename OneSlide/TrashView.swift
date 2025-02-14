import SwiftUI
import Photos

struct TrashView: View {
    @Binding var deletedPhotos: [Photo]
    @State private var previewPhoto: Photo? = nil
    
    let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 2)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(deletedPhotos) { photo in
                        PhotoCard(photo: photo)
                            .aspectRatio(1, contentMode: .fill)
                            .clipped()
                            .onLongPressGesture {
                                previewPhoto = photo
                            }
                    }
                }
            }
            .navigationBarItems(trailing:
                Button(action: {
                    deleteAllPhotos()
                }) {
                    Text("删除全部")
                }
            )
            .sheet(item: $previewPhoto) { photo in
                PhotoPreviewView(photo: photo)
            }
        }
    }
    
    private func deleteAllPhotos() {
        PHPhotoLibrary.shared().performChanges({
            let assetsToDelete = deletedPhotos.map { $0.asset }
            PHAssetChangeRequest.deleteAssets(assetsToDelete as NSArray)
        }, completionHandler: { success, error in
            DispatchQueue.main.async {
                if success {
                    deletedPhotos.removeAll()
                } else if let error = error {
                    print("删除照片失败: \(error.localizedDescription)")
                }
            }
        })
    }
}

struct PhotoPreviewView: View {
    let photo: Photo
    
    var body: some View {
        PhotoCard(photo: photo)
            .padding()
    }
} 