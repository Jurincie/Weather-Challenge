//
//  ImageCache.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/20/24.
//

import Foundation

struct Cache<T> {
    let maxElements: Int
    var elements: [T] = [T]()
    
    init(maxElements: Int) {
        self.maxElements = maxElements
    }
}
