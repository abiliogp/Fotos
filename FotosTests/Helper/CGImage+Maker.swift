//
//  CGImage+Maker.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 26/05/2024.
//


import CoreGraphics
import XCTest

extension CGImage {
    static func make() -> CGImage {
        let width = 1
        let height = 1
        let bitsPerComponent = 8
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        
        var pixelData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
        pixelData[0] = 255 // Red
        pixelData[1] = 0   // Green
        pixelData[2] = 0   // Blue
        pixelData[3] = 255 // Alpha
        
        let providerRef = CGDataProvider(data: NSData(bytes: &pixelData, length: pixelData.count * MemoryLayout<UInt8>.size))!
        return CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerComponent * bytesPerPixel,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGBitmapInfo(rawValue: bitmapInfo),
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )!
    }
}

