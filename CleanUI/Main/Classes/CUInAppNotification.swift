//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// ``CUInAppNotification`` allows to show and hide in app notifications
public class CUInAppNotification {
    
    /// Adds a new in app notification to the ``CUGlobal/inAppNotifications`` array, and shows it
    /// - Parameters:
    ///   - title: The title `String` for the notification
    ///   - body: The body `String` for the notification
    ///   - tapAction: The tap action, default is `nil`
    public static func show(title: String, body: String, tapAction: (() -> ())? = nil) {
        CUGlobal.inAppNotifications.add(title: title, body: body, tapAction: tapAction)
    }
    
    /// Clears a single notification
    /// - Parameter id: The id for the notification
    public static func clearSingle(_ id: UUID) {
        CUGlobal.inAppNotifications.clearSingle(id)
    }
    
    var notifications: [CUAlertModel] = []
    
    func clearSingle(_ id: UUID) {
        for noti in notifications {
            if noti.id == id {
                noti.view.removeFromSuperview()
            }
        }
    }
    
    func add(title: String, body: String, tapAction: (() -> ())?) {
        
        let id: UUID = UUID()
        
        if let controller = CUStd.getMainUIWindow()?.rootViewController {
            let notificationView = UIHostingController(rootView: CLInAppNotificationView(id: id, title: title, subTitle: body, tapAction: tapAction))
            controller.view.addSubview(notificationView.view)
            notificationView.view.translatesAutoresizingMaskIntoConstraints = false
            notificationView.view.isUserInteractionEnabled = true
            notificationView.view.backgroundColor = .clear
            
            
            
            let c1 = NSLayoutConstraint(item: notificationView.view!, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 10)
            let c2 = NSLayoutConstraint(item: notificationView.view!, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -10)
            let c3 = NSLayoutConstraint(item: notificationView.view!, attribute: .top, relatedBy: .equal, toItem: controller.view, attribute: .top, multiplier: 1, constant: 0)
            
            controller.view.addConstraints([c1, c2, c3])
            
            
            UIView.animate(withDuration:0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [UIView.AnimationOptions.curveEaseIn], animations: { () -> Void in
                
                notificationView.view.frame.origin.y = 200
            },  completion: {
                (value: Bool) in
            })
            
            notifications.append(CUAlertModel(id: id, view: notificationView.view))
            CUVibrate.oldSchool.vibrate()
        }
    }
}

struct CLInAppNotificationView: View {
    
    let id: UUID
    var title: String
    var subTitle: String
    var tapAction: (() -> ())?
    
    @State private var show: Bool = true
    @State private var offset = CGSize.zero
    
    var body: some View {
        if show {
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(Color.defaultText)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                HStack {
                    Text(subTitle)
                        .lineLimit(1)
                        .font(.subheadline)
                        .foregroundColor(Color.defaultText)
                    Spacer()
                }
            }
            .padding(16)
            .frame(width: UIScreen.main.bounds.width - 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.alert)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(Color.defaultBorder, lineWidth: 0.4)
                    )
            )
            .offset(y: offset.height < 0 ? offset.height : 0)
            .transition(.move(edge: .top).combined(with: .opacity))
            .onLoad {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    close()
                }
            }
            .highPriorityGesture (
                DragGesture(coordinateSpace: .global)
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { g in
                        if (g.predictedEndTranslation.height < -30) {
                            close()
                        } else {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                offset = .zero
                            }
                        }
                    }
            )
            .onTapGesture {
                if let tapAction = tapAction {
                    tapAction()
                }
            }
        }else {
            EmptyView()
        }
    }
    
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            show = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            CUInAppNotification.clearSingle(id)
        }
    }
}
