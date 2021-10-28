//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// Returns a ``CLFeedTitle`` for implementation in feeds or forms
public struct CLFeedTitle: View {
    
    var title: String
    var withMargin: Bool
    
    /// - Parameters:
    ///   - title: The title `String`
    ///   - withMargin: Should the default padding be applied? Default is `true
    public init(_ title: String, withMargin: Bool = true) {
        self.title = title
        self.withMargin = withMargin
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.defaultText)
                .textCase(.none)
            Spacer()
        }
        .if(withMargin, transform: { view in
            view
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 8)
        })
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
    }
}
