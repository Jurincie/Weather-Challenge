//
//  ImageCache.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/20/24.
//

import Foundation
import SwiftUI

struct AsyncImageCache {
    let maxElements: Int
    var elements = [AsyncImage<Image>]()
    
    init(maxElements: Int) {
        self.maxElements = maxElements
    }
}
