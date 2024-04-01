//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vita Hoang on 3/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var countries = Country.countries
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionAnswered = 0
    @State private var maxQuestion = 5

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer].name)
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                        HStack {
                            ForEach(0 ..< 3) { number in
                                Button {
                                    flagTapped(number)
                                } label: {
                                    Text(countries[number].flag)
                                        .clipShape(.capsule)
                                        .shadow(radius: 5)
                                }
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                }
                Text("Score: \(score)/\(maxQuestion)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionAnswered >= maxQuestion {
                Button("Play another round", action: resetGame)
            } else {
                Button("Continue", action: askQuestion)
            }
        } message: {
            Text("Your score is \(score)/\(maxQuestion)")
        }
    }

    func flagTapped(_ number: Int) {
        questionAnswered += 1
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }

    func resetGame() {
        score = 0
        questionAnswered = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
