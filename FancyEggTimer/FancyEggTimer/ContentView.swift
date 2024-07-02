//
//  ContentView.swift
//  FancyEggTimer
//
//  Created by Fernando on 7/2/24.
//

import SwiftUI

struct CircularProgressView: View {
    
    let progress: Double
    
    var body: some View {
            ZStack {
                // empty circle
                Circle()
                    .stroke(
                        Color.gray.opacity(0.4),
                        lineWidth: 20
                    )
                // darker circle for progress
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.yellow,
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
            }
        }
}

struct ContentView: View {
    @State var progress: Double = 0
    @State var selectedEgg: String = "medium_egg"
    @State private var timer: Timer?
    @State private var elapsedTime: Int = 0
    
    let eggTimes: [String: Int] = ["soft_egg": 3, "medium_egg": 4, "hard_egg": 5]
    
    var body: some View {
            VStack {
                // Egg type selector buttons
                HStack {
                    Button(action: {
                        selectedEgg = "soft_egg"
                        print("Selected egg: \(selectedEgg)")
                    }) {
                        Text("Soft")
                            .padding()
                            .background(selectedEgg == "soft_egg" ? Color.yellow : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        selectedEgg = "medium_egg"
                        print("Selected egg: \(selectedEgg)")
                    }) {
                        Text("Medium")
                            .padding()
                            .background(selectedEgg == "medium_egg" ? Color.yellow : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        selectedEgg = "hard_egg"
                        print("Selected egg: \(selectedEgg)")
                    }) {
                        Text("Hard")
                            .padding()
                            .background(selectedEgg == "hard_egg" ? Color.yellow : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer()
                
                ZStack {
                    Image(selectedEgg)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 300)
                    
                    CircularProgressView(progress: progress)
                        .offset(x: -4, y: 19)
                    
                    Text("\(progress * 100, specifier: "%.0f")%")
                        .font(.largeTitle)
                        .bold()
                        .offset(x: -4, y: 19)
                }
                .frame(width: 200, height: 200)
                
                Spacer()
                
                HStack {
                    Slider(value: $progress, in: 0...1)
                        .onChange(of: progress) { _, newValue in
                            print("Slider progress: \(newValue)")
                        }
                    Button("Reset") {
                        resetProgress()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                
                Button("Start") {
                    startTimer()
                }
                .frame(width: 700) // Expand button width to fill available space
                .buttonStyle(.borderedProminent)
                .padding([.leading, .trailing])
            }
        
            .background(Color.gray.edgesIgnoringSafeArea(.all))
            .onDisappear {
                timer?.invalidate()
            }
        }
        
    func resetProgress() {
            progress = 0
            timer?.invalidate()
            elapsedTime = 0
        }
        
        func startTimer() {
            guard let eggTime = eggTimes[selectedEgg] else {
                return
            }
            
            resetProgress()
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                elapsedTime += 1
                if elapsedTime <= eggTime {
                    progress = Double(elapsedTime) / Double(eggTime)
                } else {
                    timer?.invalidate()
                }
            }
        }
    }


#Preview {
    ContentView()
}
