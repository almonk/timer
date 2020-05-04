//
//  ContentView.swift
//  Timer
//
//  Created by Alasdair Lampon-Monk on 04/05/2020.
//  Copyright © 2020 Replay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var timeInSeconds : Int = 0
    @State var timerIsActive = false
    @State var timer : Timer? = nil
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.black.opacity(0.05))
                Text(timeInSeconds.secondsToTime())
                    .font(Font.system(size:18, design: .monospaced))
                    .padding(.vertical, 8)
            }
            
            HStack {
                Button(action: {
                    self.startTimer()
                }) {
                    Text("Start")
                }.disabled(timerIsActive || timeInSeconds > 0)
                
                Button(action: {
                    self.timerIsActive.toggle()
                }) {
                    Text(!timerIsActive ? "Resume" : "Pause")
                }.disabled(timer == nil)
                .frame(width: 90)
                
                Button(action: {
                    self.timerIsActive = false
                    self.timer?.invalidate()
                    self.timer = nil
                    self.timeInSeconds = 0
                }) {
                    Text("Reset")
                }
            }
        }.padding(.horizontal, 20)
        .padding(.vertical, 15)
    }
    
    private func startTimer() {
        self.timeInSeconds = 0
        self.timerIsActive = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timerIsActive {
                self.timeInSeconds += 1
            }
       }
    }
}

extension Int {

    func secondsToTime() -> String {

        let (h,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)

        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"

        return "\(h_string):\(m_string):\(s_string)"
    }
}
