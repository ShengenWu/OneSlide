import SwiftUI

struct UnorganizedView: View {
    @State private var photos: [Photo] = [
        Photo(imageName: "photo1"),
        Photo(imageName: "photo2"),
        Photo(imageName: "photo3")
    ]
    @State private var deletedPhotos: [Photo] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                ForEach(photos) { photo in
                    PhotoCard(photo: photo)
                        .gesture(
                            DragGesture()
                                .onEnded { gesture in
                                    if gesture.translation.width < -100 {
                                        // 左划保留
                                        withAnimation {
                                            photos.removeAll { $0.id == photo.id }
                                        }
                                    } else if gesture.translation.width > 100 {
                                        // 右划删除
                                        withAnimation {
                                            photos.removeAll { $0.id == photo.id }
                                            deletedPhotos.append(photo)
                                        }
                                    }
                                }
                        )
                }
            }
            .navigationBarItems(trailing:
                NavigationLink(destination: TrashView(deletedPhotos: $deletedPhotos)) {
                    Image(systemName: "trash")
                        .overlay(
                            Text("\(deletedPhotos.count)")
                                .font(.caption)
                                .padding(4)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                        )
                }
            )
        }
    }
} 