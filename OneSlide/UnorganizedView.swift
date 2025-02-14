import SwiftUI

struct UnorganizedView: View {
    @StateObject private var photoLoader = PhotoLoader()
    @State private var deletedPhotos: [Photo] = []
    @State private var currentIndex: Int = 0
    @State private var offset: CGSize = .zero
    @State private var lastAction: (action: String, photo: Photo)? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                // 显示下一张照片
                if currentIndex + 1 < photoLoader.photos.count {
                    PhotoCard(photo: photoLoader.photos[currentIndex + 1])
                        .scaleEffect(0.9)
                        .offset(y: 20)
                        .opacity(0.8)
                }
                
                // 显示当前照片
                if currentIndex < photoLoader.photos.count {
                    VStack {
                        PhotoCard(photo: photoLoader.photos[currentIndex])
                            .offset(offset)
                            .rotationEffect(.degrees(min(max(Double(offset.width / 20), -30), 30)))
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        offset = gesture.translation
                                    }
                                    .onEnded { gesture in
                                        withAnimation(.interactiveSpring()) {
                                            if abs(gesture.translation.width) > 100 {
                                                if gesture.translation.width < 0 {
                                                    // 左划保留
                                                    lastAction = ("保留", photoLoader.photos[currentIndex])
                                                    currentIndex += 1
                                                } else {
                                                    // 右划删除
                                                    lastAction = ("删除", photoLoader.photos[currentIndex])
                                                    deletedPhotos.append(photoLoader.photos[currentIndex])
                                                    currentIndex += 1
                                                }
                                            }
                                            offset = .zero
                                        }
                                    }
                            )
                        
                        if offset.width > 50 {
                            Text("删除")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                .padding()
                        } else if offset.width < -50 {
                            Text("保留")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                                .padding()
                        }
                    }
                } else {
                    Text("所有照片已处理完毕")
                        .font(.title)
                        .padding()
                }
            }
            .navigationBarItems(leading:
                Button(action: {
                    undoLastAction()
                }) {
                    Image(systemName: "arrow.uturn.backward.circle")
                        .disabled(lastAction == nil)
                },
                trailing:
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
    
    private func undoLastAction() {
        guard let lastAction = lastAction else { return }
        
        withAnimation {
            if lastAction.action == "删除" {
                if let index = deletedPhotos.firstIndex(where: { $0.id == lastAction.photo.id }) {
                    deletedPhotos.remove(at: index)
                }
            }
            currentIndex -= 1
            self.lastAction = nil
        }
    }
} 