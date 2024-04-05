//
//  ColorView.swift
//  Edutainment
//
//  Created by Vita Hoang on 4/3/24.
//

import Foundation
import SwiftUI

struct BlueGradient: View {

    
          static let color0 = Color(red: 63/255, green: 81/255, blue: 181/255);
        
          static let color1 = Color(red: 0/255, green: 188/255, blue: 212/255);
        
          static let color2 = Color(red: 76/255, green: 175/255, blue: 80/255);
        

    let gradient = Gradient(colors: [color0, color1, color2]);
    
    var body: some View {
      Rectangle()
        .fill(LinearGradient(
          gradient: gradient,
          startPoint: .init(x: 0.43, y: 0.01),
          endPoint: .init(x: 0.57, y: 0.99)
        ))
      .edgesIgnoringSafeArea(.all)
        
    }

}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        BlueGradient()
    }
}
