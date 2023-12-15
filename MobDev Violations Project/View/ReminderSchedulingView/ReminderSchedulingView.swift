//
//  NotificationScheduleView.swift
//  MobDev Violations Project
//
//  Created by octopus on 12/6/23.
//

import SwiftUI
import UserNotifications
import AVFoundation

struct ReminderSchedulingView: View {
    @Binding var hideEveryThing: Bool
    @State private var scheduleTime = Date()
    @State private var notificationsDisabledMessage = false
    var bin_id = "1076262" // default bin id
    @State private var subtitle = ""
    @State private var reminderViewOpen: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            if reminderViewOpen{
                HStack{
                    DatePicker("-", selection: $scheduleTime, in: Date()...)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.fill)
                        .cornerRadius(5)
                        .datePickerStyle(WheelDatePickerStyle())
                }
                .padding(.horizontal)
                
                HStack{
                    TextField("Enter Reminder Text", text: $subtitle)
                        .onChange(of: subtitle) {
                            print(subtitle)
                            if subtitle.count > 30 {
                                subtitle = String(subtitle.prefix(30))
                            }
                        }
                        .frame(height: 50)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.fill)
                        .cornerRadius(5)
                }
                .padding(.horizontal)
                
                HStack{
                    Button("Schedule Reminder") {
                        let content = UNMutableNotificationContent()
                        content.title = "Reminder to review: \(bin_id)"
                        content.subtitle = subtitle
                        content.sound = UNNotificationSound.default

                        // show this notification five seconds from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (scheduleTime.timeIntervalSinceNow >= Date().timeIntervalSinceNow + 5) ? scheduleTime.timeIntervalSinceNow : Date().timeIntervalSinceNow + 5, repeats: false)

                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                        
                        withAnimation(
                            .bouncy(duration: 0.3)) {
                                reminderViewOpen = false
                                subtitle = ""
                                scheduleTime = Date()
                                hideEveryThing = false
                            }
                        AudioServicesPlaySystemSound(1110)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.fill)
                    .cornerRadius(5)
                }
                .padding(.horizontal)
            }
            
            if notificationsDisabledMessage {
                HStack{
                    Text("Please Allow Notifications in Settings")
                        .italic()
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.fill)
                        .cornerRadius(5)
                }
                .padding(.horizontal)
            }
            
            HStack{
                Button(reminderViewOpen ? "Cancel" : "Set a Reminder") {
                    let current = UNUserNotificationCenter.current()

                    current.getNotificationSettings(completionHandler: { (settings) in
                        if settings.authorizationStatus == .notDetermined {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("All set!")
                                } else if let error = error {
                                    print("Not Set!")
                                    print(error.localizedDescription)
                                }
                            }
                            
                        } else if settings.authorizationStatus == .denied {
                            withAnimation(
                                .bouncy(duration: 0.3)){
                                    notificationsDisabledMessage = true
                                    reminderViewOpen = false
                                    hideEveryThing = false
                                }
                            
                        } else if settings.authorizationStatus == .authorized {
                            withAnimation(
                                .bouncy(duration: 0.3)) {
                                    notificationsDisabledMessage = false
                                    reminderViewOpen = !reminderViewOpen
                                    hideEveryThing = reminderViewOpen
                                    subtitle = ""
                                    scheduleTime = Date()
                                }
                        }
                    })
                }
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.fill)
                .cornerRadius(5)
            }
            .padding(.horizontal)
        }
        .foregroundColor(Color.primary)
        .onAppear(){
            reminderViewOpen = false
        }
    }
}

//#Preview {
//    NotificationScheduleView(bin_id: "1076262")
//}
