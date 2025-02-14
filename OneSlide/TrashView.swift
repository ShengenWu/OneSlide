import SwiftUI

struct TrashView: View {
    @Binding var deletedPhotos: [Photo]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(deletedPhotos) { photo in
                        Image(photo.imageName)
                            .resizable()
                            .scaledToFill()
                    }
                }
            }
            .navigationBarItems(trailing:
                Button(action: {
                    deletedPhotos.removeAll()
                }) {
                    Text("删除全部")
                }
            )
        }
    }
} 