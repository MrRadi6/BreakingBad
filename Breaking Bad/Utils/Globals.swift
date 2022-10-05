//
//  Globals.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

func dLog(_ message: Any) {
    #if DEBUG
    print(">>>>>>>>>>>>>>>.<<<<<<<<<<<<<<<")
    print(message)
    print(">>>>>>>>>>>>>>>.<<<<<<<<<<<<<<<")
    #endif
}
