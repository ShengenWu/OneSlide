import SwiftUI
import Photos

struct TrashView: View {
    @Binding var deletedPhotos: [Photo]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(deletedPhotos) { photo in
                        PhotoCard(photo: photo)
                            .frame(width: 100, height: 100)
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