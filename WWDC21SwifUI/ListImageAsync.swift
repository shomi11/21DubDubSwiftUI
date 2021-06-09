//
//  List21ImageAsync.swift
//  WWDC21SwifUI
//
//  Created by Milos Malovic on 9.6.21..
//

import SwiftUI

@available(iOS 15.0, *)
struct ListImageAsync: View {

    @StateObject private var photoStore = PhotoStore()

    var body: some View {
        NavigationView {
            List(photoStore.photos) { imageBmw in
                AsyncImage(url: imageBmw.url) { image in
                    BmwView(image: image.image)
                }
            }
            .listStyle(.plain)
            .refreshable {
                await photoStore.update()
            }
            .navigationTitle(Text("BMW"))
        }
    }
}

@available(iOS 15.0, *)
struct List21ImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        ListImageAsync()
    }
}

fileprivate struct ImageBMW: Identifiable {
    var id: URL { url }
    var url: URL
}

fileprivate class PhotoStore: ObservableObject {
    @Published var photos: [ImageBMW] = []

    func update() async {
        photos.removeAll()
        ImageUrls.imageURLs.forEach { url in
            if let url = URL(string: url) {
                let bmw = ImageBMW(url: url)
                photos.append(bmw)//
            }
        }
    }
}

@available(iOS 15.0, *)
fileprivate struct BmwView: View {

    var image: Image?

    init(image: Image?) {
        self.image = image
    }

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 400)
        }
        .mask(RoundedRectangle(cornerRadius: 12))
    }
}

