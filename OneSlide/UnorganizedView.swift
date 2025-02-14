import SwiftUI

struct UnorganizedView: View {
    @StateObject private var photoLoader = PhotoLoader()
    @State private var deletedPhotos: [Photo] = []
    @State private var currentIndex: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                if currentIndex < photoLoader.photos.count {
                    PhotoCard(photo: photoLoader.photos[currentIndex])
                        .gesture(
                            DragGesture()
                                .onEnded { gesture in
                                    if gesture.translation.width < -100 {
                                        // 左划保留
                                        withAnimation {
                                            currentIndex += 1
                                        }
                                    } else if gesture.translation.width > 100 {
                                        // 右划删除
                                        withAnimation {
                                            deletedPhotos.append(photoLoader.photos[currentIndex])
                                            currentIndex += 1
                                        }
                                    }
                                }
                        )
                } else {
                    Text("所有照片已处理完毕")
                        .font(.title)
                        .padding()
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