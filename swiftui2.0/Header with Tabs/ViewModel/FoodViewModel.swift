//
//  FoodViewModel.swift
//  swiftui2.0
//
//  Created by Faizan  Naseem on 18/01/2021.
//

import Foundation
import SwiftUI

class FoodViewModel: ObservableObject {
    
    @Published var offset : CGFloat = 0
    
    // selected tab...
    @Published var selectedTab = tabsItems.first!.tab
}
