//
//  ContentView.swift
//  Edutainment
//
//  Created by Vita Hoang on 4/3/24.
//

import SwiftUI

struct ContentView: View {
    // content var
    @State private var tableLevel = 2
    @State private var questionNo = [5, 10, 15, 20]
    @State private var questionNoIndex = -1

    @State private var totalNoQuestion = 5
    @State private var questionList = [:]
    @State private var curQuestion = """
    Choose level and 
    number of question to

    ⬇️⬇️⬇️
    """
    @State private var curAnswer = ""
    @State private var textFieldError = ""

    // state var
    @State private var answered = 0
    @State private var score = 0
    @ObservedObject var viewModel = ContentViewModel()

    
    // forcus var
    enum Field: Hashable {
        case answer
        case Void
    }

    @FocusState private var focusedField: Field?

    // UI vars
    @State private var maxWidth: CGFloat = .zero
    @State private var aniOpacity: CGFloat = 1
    @State private var animationConfetti = false

    var body: some View {
        NavigationStack {
            Section {
                VStack {
                    CardStack {
                        HStack {
                            if !viewModel.isInit {
                                Headline("🐰 Total Questions")
                                Spacer()
                                HStack {
                                    ForEach(0 ..< questionNo.count, id: \.self) { index in
                                        Button {
                                            totalNoQuestion = questionNo[index]
                                            questionNoIndex = index
                                            withAnimation {
                                                aniOpacity = 0.6
                                            }
                                        } label: {
                                            NumberOfQuestionButon(String(questionNo[index]))
                                        }
                                        .opacity(index != questionNoIndex ? aniOpacity : 1)
                                    }
                                }
                            } else {
                                Headline("🐰 Total Questions: \(totalNoQuestion)")
                                Spacer()
                                Headline("🐇 Table Level: \(tableLevel)")
                            }
                        }
                    }
                    CardStack {
                        if !viewModel.isInit {
                            Headline("🐇 Table Level")
                            Spacer()
                            HStack {
                                Headline("\(tableLevel)")
                                Stepper("Choose Level", value: $tableLevel, in: 2 ... 12)
                                    .labelsHidden()
                            }
                        } else {
                            Text("Carrot: \(score)🥕")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Edutainment")
            ZStack {
                BlueGradient()
                if animationConfetti {
                    ConfettiView(didFinish: $animationConfetti)
                }
                VStack {
                    QuestionText(content: $curQuestion)
                        .padding(.top, 40)
                        .multilineTextAlignment(.center)
                    if !viewModel.isInit {
                        Button {
                            SoundManager(resource: "success").playSound()
                            initQuestion()
                        } label: {
                            StartButton("Start")
                        }
                    } else {
                        if !viewModel.newRound {
                            AnswerTextField(title: "Your Answer", text: $curAnswer, error: textFieldError)
                                .focused($focusedField, equals: .answer)
                        }
                    }

                    if viewModel.newRound {
                        HStack {
                            Button {
                                initQuestion()
                            } label: {
                                StartButton("Start")
                            }
                            Button {
                                reset()
                            } label: {
                                StartButton("🎯 Change Rule")
                            }
                        }
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
            .cornerRadius(20)
            .padding(.top)
            .ignoresSafeArea()
            .frame(maxHeight: .infinity)
            .toolbar {
                if viewModel.isInit && !viewModel.newRound {
                    ToolbarItem(placement: .keyboard) {
                        Button("Answer") {
                            answer(curQuestion, curAnswer)
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        Button("🎯 New game") {
                            reset()
                        }
                    }
                }
            }
        }
    }

    func initQuestion() {
        for int in 0 ... 12 {
            questionList["\(tableLevel) x \(int) = 🙋🙋‍♀️🙋‍♂️ "] = "\(tableLevel * int)"
        }
        answered = 0
        viewModel.newRound = false
        viewModel.isInit = true
        drawQuestion()
    }

    func drawQuestion() {
        if answered < totalNoQuestion {
            let q = questionList.randomElement()?.key as! String
            curQuestion = q
            print(q)
            focusedField = .answer
        } else {
            endTurn()
        }
    }

    func answer(_ question: String, _ answer: String) {
        let trueA = questionList[question] as! String
        textFieldError = ""
        guard answer != "" else {
            textFieldError = "⚠ Please enter your answer"
            return
        }
        if answer == trueA {
            print("true")
            score += 1
            withAnimation {
                animationConfetti.toggle()
            }
        } else {
            print("false")
        }
        answered += 1
        curAnswer = ""
        drawQuestion()
    }

    func endTurn() {
        focusedField = .Void
        curQuestion = "Play Another Round"
        viewModel.newRound = true
    }

    func reset() {
        viewModel.isInit = false
        viewModel.newRound = false
        score = 0
        answered = 0
        curQuestion = """
        Choose level and
        number of question to

        ⬇️⬇️⬇️
        """
    }
}

#Preview {
    ContentView()
}

enum Preview {
    @State static var finish = true
    @State static var title = "test"
    @State static var text = "test"
    @State static var error = "error"
}
