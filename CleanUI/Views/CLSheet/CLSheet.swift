//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// This is the main Sheet wrapper
internal struct CLSheet<Content: View>: View {
    
    var content: Content
    @StateObject private var viewModel: CLSheetViewModel = CLSheetViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if(viewModel.showBackground){
                    Color.black
                        .opacity(0.25)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                }
                
                VStack(spacing: 0) {
                    Color.black
                        .opacity(0.001)
                        .onTapGesture {
                            viewModel.close()
                        }
                    
                    if viewModel.isShowing {
                        VStack(spacing: 0) {
                            HStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(.secondary)
                                    .frame(width: 35, height: 5, alignment: .center)
                                    .opacity(0.6)
                            }
                            .padding(.top, 5)
                            .padding(.bottom, 10)
                            
                            content
                            
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width, height: (geometry.safeAreaInsets.bottom + 50) + abs(viewModel.offset.height) / 4)
                        }
                        .transition(.move(edge: .bottom))
                        .frame(width: UIScreen.main.bounds.width)
                        .background(Color.alert)
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                        .offset(x: 0, y: viewModel.offset.height > 0 ? viewModel.offset.height + 50 : 50)
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .ignoresSafeArea(edges: .bottom)
            .highPriorityGesture (
                DragGesture(coordinateSpace: .global)
                    .onChanged { gesture in
                        viewModel.offset = gesture.translation
                    }
                    .onEnded { g in
                        if (viewModel.offset.height > 0 && abs(viewModel.offset.height) > 60) {
                            viewModel.close()
                        } else {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                viewModel.offset = .zero
                            }
                        }
                    }
            )
            .onLoad {
                viewModel.height = geometry.size.height
                viewModel.didLoad()
            }
        }
    }
}
