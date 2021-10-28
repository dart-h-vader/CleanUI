//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// A ``CLLinearProgress``  for indacting any type of progress
public struct CLLinearProgress: View {
    
    var progress: CGFloat
    
    /// - Parameter progress: The current progress 0 -> 0%, 100 -> 100%
    public init(_ progress: CGFloat) {
        self.progress = progress
    }
    
    public var body: some View {
        CLKnogglGradient()
            .frame(height: 4)
            .mask(
                ProgressView(value: progress, total: 100)
                    .progressViewStyle(LinearProgressViewStyle())
            )
    }
}
