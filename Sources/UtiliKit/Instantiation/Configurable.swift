//
//  Configurable.swift
//  UtiliKit-iOS
//
//  Created by Will McGinty on 5/4/18.
//  Copyright © 2018 Bottle Rocket Studios. All rights reserved.
//

import Foundation

//MARK: Configurable
public protocol Configurable {
    associatedtype ConfiguringType
    
    /// Configures `Self` with `element`.
    func configure(with element: ConfiguringType)
}
