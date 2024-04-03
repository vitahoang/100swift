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
    @State private var selectedAnswer = 0

    // animation vars
    @State var haveChosen = false
    @State var animateOpacity = 0.0
    @State var animateCorrect = 0.0
    @State var animateNewGame = 0.0
    @State var scaleAmount = 1.0

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
                                    withAnimation {
                                        self.flagTapped(number)
                                        self.selectedAnswer = number
                                    }
                                } label: {
                                    Text(self.countries[number].flag)
                                        .clipShape(.capsule)
                                        .shadow(radius: 5)
                                }
                                .rotation3DEffect(.degrees(number == self.correctAnswer ? self.animateCorrect : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(number != self.correctAnswer && haveChosen ? self.animateOpacity : 1)
                                .scaleEffect(number != self.correctAnswer && haveChosen ? self.scaleAmount : 1)
                                // animation for a new game
                                .rotation3DEffect(.degrees(animateNewGame), axis: (x: 1, y: 0, z: 0))
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
        haveChosen = true
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"

            withAnimation {
                self.animateCorrect += 360
                self.animateOpacity = 0.25
            }
        } else {
            scoreTitle = "Wrong"
            withAnimation(.easeIn(duration: 2.0)) {
                self.animateOpacity = 0.25
                self.scaleAmount -= 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showingScore = true
            haveChosen = false
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        scaleAmount = 1.0
        withAnimation {
            animateNewGame += 360
        }
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
