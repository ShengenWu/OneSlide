import Foundation
import Photos

struct Photo: Identifiable {
    let id = UUID()
    let asset: PHAsset
} 