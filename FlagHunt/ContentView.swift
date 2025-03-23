//
//  ContentView.swift
//  FlagHunt
//
//  Created by Kamol Madaminov on 23/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionsAnswered = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.05, green: 0.15, blue: 0.4), location: 0.3),
                .init(color: Color(red: 0.9, green: 0.6, blue: 0.2), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                    .ignoresSafeArea()
            
            VStack{

                Spacer()

                Text("Hunt the flags!")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score) / \(questionsAnswered)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()

            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Reset", action: resetGame)
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(score) / \(questionsAnswered)")
        }
    }
    
    
    func flagTapped(_ number: Int) {
        questionsAnswered += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame(){
        score = 0
        questionsAnswered = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
