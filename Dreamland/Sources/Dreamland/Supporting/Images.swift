//
//  Images.swift
//  Dreamland
//
//  Created by DevMountain on 7/17/21.
//

import UIKit
import SwiftUI

class MarkerClass {}

extension Bundle {
    public static var dreamland: Bundle {
        return Bundle(for: MarkerClass.self)
    }
}

private struct ImageNames {
    static let logo = "logo"
}

public extension UIImage {
    static let logo = UIImage(named: ImageNames.logo, in: .dreamland, with: nil)!
}

public extension Image {
    static let logo = Image.init(ImageNames.logo, bundle: .dreamland)
}
