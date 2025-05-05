//
//  LocalPushNotificationsExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 28/09/2024.
//



// MARK: - NOTES

// MARK: 11 - How to schedule local Push Notifications in SwiftUI
///
/// - aby dodać powiadomienia potrzebujemy zaimportować framework `UserNotifications`
/// - na początek musimy wysłać do usera prośbę o zaakcaptowanie zgód na konkretne rzeczy
/// - robimy to za pomocą metody `requestAuthorization` podając opcje typu `UNAuthorizationOptions`
/// - do wyboru mamy: alert, badge, provisional, carPlay, criticalAlert, providesAppNotificationSettings, sound
/// - do stworzenia obiektu notyfikacji używamy obiektu `UNMutableNotificationContent`
/// - do ustawienia wysyłania notyfikacji używamy obiektu `UNNotificationRequest`
/// - argument `trigger` pozwala ustawić w zależności od czego  notyfikacja ma się wyświetlać - time, calendar, location
/// - jeśli ustawimy badge na ikonie appki to musimy to potem ręcznie usunąć metodą `setBadgeCount(0)`
/// - jeśli ustawiamy notyfikację zależną od `calendar` to ustawiając `dateComponents` ustawiamy że będzie się pojawiać każdego dnia o ustawionej godzinie
/// - w `dateComponents` możemy ustawić bardzo dokładnie konkretny dzień, tydzień lub rok



// MARK: - CODE

import CoreLocation
import SwiftUI
import UserNotifications

struct LocalPushNotificationsExample: View {
    
    // MARK: - Classes
    
    final class NotificationManager {
        static let shared = NotificationManager()
        
        func requestAuthorization() {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]
            ) { success, error in
                if let error {
                    print("ERROR: \(error.localizedDescription)")
                } else {
                    print("SUCCESS")
                }
            }
        }
        
        func scheduleNotification() {
            let content = UNMutableNotificationContent()
            content.title = "First notification"
            content.subtitle = "This is my first notification and it is easy..."
            content.sound = .default
            content.badge = 1
            
            // - TIME
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 5.0,
                repeats: false
            )
            
            // - CALENDAR
            // var dateComponents = DateComponents()
            // dateComponents.hour = 23
            // dateComponents.minute = 58
            // dateComponents.second = 30
            // dateComponents.weekday = 6 // 0-Sunday, ..., 6-Saturday
            // let trigger = UNCalendarNotificationTrigger(
            //     dateMatching: dateComponents,
            //     repeats: false
            // )
            
            // - LOCATION
            // let coordinates = CLLocationCoordinate2D(
            //     latitude: 52.247288,
            //     longitude: 16.847565
            // )
            // let region = CLCircularRegion(
            //     center: coordinates,
            //     radius: 1000,
            //     identifier: UUID().uuidString
            // )
            // region.notifyOnEntry = true
            // region.notifyOnExit = true
            // let trigger = UNLocationNotificationTrigger(
            //     region: region,
            //     repeats: false
            // )
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            UNUserNotificationCenter.current().add(request)
        }
        
        func cancelNotifications() {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
        
        func clearBadgeCount() async throws {
            try await UNUserNotificationCenter.current().setBadgeCount(0)
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Request permission") {
                NotificationManager.shared.requestAuthorization()
            }
            Button("Schedule notification") {
                NotificationManager.shared.scheduleNotification()
            }
            Button("Cancel notifications") {
                NotificationManager.shared.cancelNotifications()
            }
        }
        .task {
            try? await NotificationManager.shared.clearBadgeCount()
        }
    }
}

// MARK: - Preview

#Preview {
    LocalPushNotificationsExample()
}
