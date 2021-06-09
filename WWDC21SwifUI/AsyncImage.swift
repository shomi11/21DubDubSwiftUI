//
//  List21.swift
//  WWDC21SwifUI
//
//  Created by Milos Malovic on 9.6.21..
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct AsyncImage21: View {

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))]) {
                    ForEach(ImageUrls.imageURLs, id: \.self) { url in
                        AsyncImage(url: URL(string: url)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.red
                        }
                    }
                    .mask(RoundedRectangle(cornerRadius: 12))
                    .padding()
                }

            }
            .navigationTitle(Text("BMW"))
        }
    }
}

struct ImageUrls {
    static var imageURLs = [
        "https://image.shutterstock.com/z/stock-photo-la-california-february-bmw-m-f-on-the-parking-lot-editorial-photo-1035959809.jpg",
        "https://image.shutterstock.com/z/stock-photo-bucharest-romania-august-bmw-x-m-competition-front-view-1803965659.jpg",
        "https://image.shutterstock.com/z/stock-photo-belgrade-serbia-march-bmw-m-i-image-1409474015.jpg",
        "https://image.shutterstock.com/z/stock-photo-new-aggressive-headlight-by-night-car-details-the-front-lights-of-the-sports-car-car-s-light-490134517.jpg",
        "https://image.shutterstock.com/z/stock-photo-bucegi-romania-november-bmw-x-m-d-wallpaper-1590960883.jpg",
        "https://image.shutterstock.com/z/stock-photo-riga-lv-dec-bmw-x-f-at-the-winter-1268237848.jpg",
        "https://image.shutterstock.com/image-photo/novosibirsk-russia-february-16-2019-600w-1314409679.jpg",
        "https://image.shutterstock.com/image-photo/prague-czech-republic-08-11-600w-1910300299.jpg",
        "https://image.shutterstock.com/image-photo/beijing-may-2-acs5-falcon-600w-52410373.jpg",
        "https://image.shutterstock.com/image-photo/novosibirsk-russia-october-20-2020-600w-1846202290.jpg",
        "https://image.shutterstock.com/image-photo/geneva-switzerland-march-4-2014-600w-201241928.jpg"
    ]
}
