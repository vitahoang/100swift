//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Vita Hoang on 4/1/24.
//

import SwiftUI

struct ContentView: View {
    static let color0 = Color(red: 76/255, green: 175/255, blue: 80/255)
    static let color1 = Color(red: 49/255, green: 220/255, blue: 255/255)
    let gradient = Gradient(colors: [color0, color1])

    let choices = ["Rock": "✊", "Paper": "✋", "Scissor": "✌️"]
    @State private var appResult = Bool.random()
    @State private var result = false
    @State private var appChoice = ""
    @State private var scoreTitle = ""
    @State private var scoreDescription = ""
    @State private var score = 0
    @State private var totalRound = 10
    @State private var countRound = 0
    @State private var showingScore = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: gradient,
                startPoint: .init(x: 0.78, y: 0.91),
                endPoint: .init(x: 0.22, y: 0.09))
                .ignoresSafeArea()
                .onAppear {
                    appMove()
                }

            VStack {
                VStack {
                    TitleText(content: "App move")
                    Button {} label: {
                        Text(choices[appChoice] ?? "Some error!!!")
                            .clipShape(.capsule)
                    }
                    .buttonStyle(.bordered)
                    .shadow(radius: 5)
                    .foregroundColor(.white)
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                }
                .sectionStyle()

                VStack {
                    TitleText(content: "Choose your move to")
                    ResultText(appResult: appResult)
                    HStack {
                        ForEach(choices.sorted(by: >), id: \.key) { key, value in
                            Button {
                                move(key)
                            } label: {
                                Text(value)
                                    .clipShape(.capsule)
                            }
                            .buttonStyle(.bordered)
                            .shadow(radius: 5)
                            .foregroundColor(.white)
                        }
                    }
                }
                .sectionStyle()

                TitleText(content: "Score: \(score)/\(totalRound)")
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if countRound >= totalRound {
                Button("New Game", action: reset)
            } else {
                Button("Continue", action: appMove)
            }
        } message: {
            Text(scoreDescription)
        }
    }

    func appMove() {
        appResult.toggle()
        scoreDescription = "Your score is \(score)/\(totalRound)"
        appChoice = choices.randomElement()!.key
    }

    func move(_ choice: String) {
        if choice == "Rock" {
            if (appResult && appChoice == "Scissor") ||
                (!appResult && appChoice == "Paper")
            {
                win()
            } else {
                loose()
            }
        } else if choice == "Paper" {
            if (appResult && appChoice == "Rock") ||
                (!appResult && appChoice == "Scissor")
            {
                win()
            } else {
                loose()
            }
        } else if choice == "Scissor" {
            if (appResult && appChoice == "Paper") ||
                (!appResult && appChoice == "Rock")
            {
                win()
            } else {
                loose()
            }
        }
        countRound += 1
        if countRound >= totalRound {
            scoreDescription = "The game is ended. Your total score is \(score)/\(totalRound)"
        }
        showingScore = true
    }

    func win() {
        score += 1
        result = true
        scoreTitle = "RIGHT"
    }

    func loose() {
        result = false
        scoreTitle = "WRONG"
    }

    func reset() {
        countRound = 0
        score = 0
    }
}

struct ResultText: View {
    var appResult: Bool

    var body: some View {
        if appResult {
            Text("\"WIN\"")
                .foregroundStyle(.bar)
                .font(.title.weight(.bold))
                .shadow(radius: 10)
        } else {
            Text("\"LOOSE\"")
                .foregroundStyle(.black)
                .font(.title.weight(.bold))
                .shadow(radius: 10)
        }
    }
}

struct TitleText: View {
    var content: String
    var body: some View {
        Text(content)
            .foregroundStyle(.white)
            .font(.title.weight(.bold))
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct Section: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(.quaternary)
            .clipShape(.rect(cornerRadius: 20))
            .padding()
    }
}

extension View {
    func sectionStyle() -> some View {
        modifier(Section())
    }
}

#Preview {
    ContentView()
}
