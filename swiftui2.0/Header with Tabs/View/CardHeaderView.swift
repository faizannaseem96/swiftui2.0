//
//  CardHeaderView.swift
//  swiftui2.0
//
//  Created by Faizan  Naseem on 18/01/2021.
//

import SwiftUI

struct CardHeaderView: View {
    
    @EnvironmentObject var homeData: FoodViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(spacing: 0) {
                Button(action: {}, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: getSize(), height: getSize())
                        .foregroundColor(.black)
                })
                Text("Faizan Bakery")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            ZStack {
                VStack(alignment: .leading, spacing: 10, content: {
                                    
                    Text("Asiatisch . Koreanisch . Japnisch")
                        .font(.caption)
                    
                    HStack(spacing: 8) {
                        
                        Image(systemName: "clock")
                            .font(.caption)
                        
                        Text("30-40 Min")
                            .font(.caption)
                        
                        Text("4.3")
                            .font(.caption)
                        
                        Image(systemName: "star.fill")
                            .font(.caption)
                        
                        Text("$6.40 Fee")
                            .font(.caption)
                            .padding(.leading,10)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                })
                .opacity(homeData.offset > 200 ? 1 - Double((homeData.offset - 200) / 50) : 1)
                
                // Custom ScrollView....
                                
                // For Automatic Scrolling...
                
                ScrollViewReader { reader in
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 0){
                                                    
                            ForEach(tabsItems){tab in
                                Text(tab.tab)
                                    .font(.caption)
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .background(Color.black.opacity(homeData.selectedTab == tab.tab ? 1 : 0))
                                    .foregroundColor(homeData.selectedTab == tab.tab ? .white : .black)
                                    .clipShape(Capsule())
                                    .id(tab.tab)
                            }
                            .onChange(of: homeData.selectedTab, perform: { value in
                                withAnimation(.easeInOut) {
                                    reader.scrollTo(homeData.selectedTab, anchor: .leading)
                                }
                            })
                        }
                        
                    })
                    // Visible Only When Scrolls Up...
                    .opacity(homeData.offset > 200 ? Double((homeData.offset - 200) / 50) : 0)
                }
            }
            
            if homeData.offset > 250 {
                Divider()
            }
        }
        .padding(.horizontal)
        .frame(height: 100)
        .background(Color.white)
    }
    
    // get size of back button while scrolling
    func getSize() -> CGFloat {
        if homeData.offset > 200 {
            let progress = (homeData.offset - 200) / 50
            if progress <= 1.0 {
                return progress * 35
            } else {
                return 35
            }
        } else {
            return 0
        }
    }
}

struct CardHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FoodHome()
    }
}
