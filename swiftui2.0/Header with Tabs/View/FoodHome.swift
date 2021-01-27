//
//  HeaderHome.swift
//  swiftui2.0
//
//  Created by Faizan  Naseem on 18/01/2021.
//

import SwiftUI

struct FoodHome: View {
    
    @StateObject var homeData = FoodViewModel()
    
    var body: some View {
        
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders], content: {
                
                // Parallex Header ....
                GeometryReader { reader -> AnyView in
                    
                    let offset = reader.frame(in: .global).minY
                    
                    if -offset >= 0 {
                        DispatchQueue.main.async {
                            self.homeData.offset = -offset
                        }
                    }
                    
                    return AnyView(
                        Image("cookies")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 250 + (offset > 0 ? offset : 0))
                            .cornerRadius(2)
                            .offset(y: (offset > 0 ? -offset : 0))
                            .overlay(
                                HStack {
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Image(systemName: "arrow.left")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    })
                                    
                                    Spacer()
                                    
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Image(systemName: "suit.heart.fill")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    })
                                }
                                .padding(),
                                alignment: .top
                            )
                    )
                }
                .frame(height: 250)
                
                Section(header: CardHeaderView()) {
                    // Tabs with Content
                    ForEach(tabsItems) { tab in
                        VStack(alignment: .leading, spacing: 15) {
                            Text(tab.tab)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                .padding(.leading)
                            
                            ForEach(tab.foods) { food in
                                CardView(food: food)
                            }
                            
                            Divider()
                                .padding(.top)
                        }
                        .tag(tab.tab)
                        .overlay(
                            GeometryReader { reader -> Text in
                                // calculate which tab
                                let offset = reader.frame(in: .global).minY
                                // Top Area plus Header Size 100
                                let height = UIApplication.shared.windows.first!.safeAreaInsets.top + 100
                                if offset < height && offset > 50 && homeData.selectedTab != tab.tab {
                                    DispatchQueue.main.async {
                                        self.homeData.selectedTab = tab.tab
                                    }
                                }
                                return Text("")
                            }
                        )
                    }
                }
            })
        }
        .overlay(
            // Only Safe Area...
            Color.white
                .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                .ignoresSafeArea(.all, edges: .all)
                .opacity(homeData.offset > 250 ? 1 : 0)
            , alignment: .top
        )
        // used it environement objects for accessories all subobjects
        .environmentObject(homeData)
    }
}

struct HeaderHome_Previews: PreviewProvider {
    static var previews: some View {
        FoodHome()
    }
}
