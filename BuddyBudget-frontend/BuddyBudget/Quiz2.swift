import SwiftUI

struct Quiz2: View {
    @Environment(\.dismiss) private var dismiss
    @State var next2 = false
    @State var next3 = false
    @State var wrongFeedback = "You Can Do It!"
    @State var correctFeedback = "You Aced It!"
    @State var questionsTemp = [String]()
    @State var answersQ0Temp = [String]()
    @State var answersQ1Temp = [String]()
    @State var answersQ2Temp = [String]()
    @State var correctCount = 0
    @State var qsAnswered = 0
    @State var questions = ["What is a share?", "What is a fractional share?", "What is a dividend?"]
    @State var answersQ0 = ["A part of a company", "Money that you receive from owning stock in a company", "The profit that you earn from selling stocks", "A share that you buy that is a fraction"]
    @State var answersQ1 = ["The percent of the company that you own", "The fraction of money that is taken in capital gains tax when you sell a stock", "A share that you buy that is a fraction", "Another word for 'index fund'"]
    @State var answersQ2 = ["The amount of money a company pays you for owning a share", "The fraction of a company that you own by owning a share", "A tax that is paid on sold shares", "The business that you own a share of"]
    @State var qNum = 0
    @State var aNum = 0
    @State var answer1 = ""
    @State var answer2 = ""
    @State var answer3 = ""
    @State var answer4 = ""
    @State var question1 = ""
    @State var question2 = ""
    @State var question3 = ""
    @State var correct1 = false
    @State var correct2 = false
    @State var correct3 = false
    @State var correct4 = false
    @State var correct = false
    @State var wrong = false
    @State var correct1String = ""
    @State var correct2String = ""
    @State var correct3String = ""
    @State var correct4String = ""
    var body: some View {
            NavigationStack {
                
                ZStack {
                    
                    if !next2 {
                        
                        HStack(alignment: .center, spacing: 20) {
                            
                            Spacer()
                                    VStack(spacing: 10) {
                                        
                                        Spacer()
                                        VStack {
                                            Text("\(question1)")
                                                
                                                .multilineTextAlignment(.center)
                                        }
                                        .frame(maxWidth: .infinity)
                                        Spacer()
                                        Button("\(answer1)") {
                                            if answer1 == "A part of a company" || answer1 == "A share that you buy that is a fraction" || answer1 == "The amount of money a company pays you for owning a share" {
                                                correct1 = true
                                                correct1String = "true"
                                                correct = true
                                                wrong = false
                                                if qsAnswered == 0 {
                                                    correctCount += 1
                                                    qsAnswered += 1
                                                }
                                            } else {
                                                correct1 = false
                                                correct2 = false
                                                correct3 = false
                                                correct4 = false
                                                correct2String = "false"
                                                correct = false
                                                wrong = true
                                                if qsAnswered == 0 {
                                                    qsAnswered += 1
                                                }
                                            }
                                            print("\(correctCount)/\(qsAnswered)")
                                        }
                                        .frame(width: UIScreen.main.bounds.width * 3/4)
                                        .font(.system(size: 25))
                                        .padding(.all, 10.0)
                                        .tint(Color(correct1 ? "000000" : "FFFFFF"))
                                        .background(Color(correct1 ? "A6FF91" : "007FFF"))
                                        .cornerRadius(30)
                                        .shadow(color: correct1 ? Color("A2A4A4") : Color("FFFFFF"), radius: 10, x: 0, y: 5)
                                        Button("\(answer2)") {
                                            if answer2 == "A part of a company" || answer2 == "A share that you buy that is a fraction" || answer2 == "The amount of money a company pays you for owning a share" {
                                                correct2 = true
                                                correct2String = "true"
                                                correct = true
                                                wrong = false
                                                if qsAnswered == 0 {
                                                    correctCount += 1
                                                    qsAnswered += 1
                                                }
                                            } else {
                                                correct1 = false
                                                correct2 = false
                                                correct3 = false
                                                correct4 = false
                                                correct2String = "false"
                                                correct = false
                                                wrong = true
                                                if qsAnswered == 0 {
                                                    qsAnswered += 1
                                                }
                                            }
                                            print("\(correctCount)/\(qsAnswered)")
                                        }
                                        .frame(width: UIScreen.main.bounds.width * 3/4)
                                        .font(.system(size: 25))
                                        .padding(.all, 10.0)
                                        .tint(Color(correct2 ? "000000" : "FFFFFF"))
                                        .background(Color(correct2 ? "A6FF91" : "007FFF"))
                                        .cornerRadius(30)
                                        .shadow(color: correct2 ? Color("A2A4A4") : Color("FFFFFF"), radius: 10, x: 0, y: 5)
                                        Button("\(answer3)") {
                                            if answer3 == "A part of a company" || answer3 == "A share that you buy that is a fraction" || answer3 == "The amount of money a company pays you for owning a share" {
                                                correct3 = true
                                                correct3String = "true"
                                                correct = true
                                                wrong = false
                                                if qsAnswered == 0 {
                                                    correctCount += 1
                                                    qsAnswered += 1
                                                }
                                            } else {
                                                correct1 = false
                                                correct2 = false
                                                correct3 = false
                                                correct4 = false
                                                correct3String = "false"
                                                correct = false
                                                wrong = true
                                                if qsAnswered == 0 {
                                                    qsAnswered += 1
                                                }
                                            }
                                            print("\(correctCount)/\(qsAnswered)")
                                        }
                                        .frame(width: UIScreen.main.bounds.width * 3/4)
                                        .font(.system(size: 25))
                                        .padding(.all, 10.0)
                                        .tint(Color(correct3 ? "000000" : "FFFFFF"))
                                        .background(Color(correct3 ? "A6FF91" : "007FFF"))
                                        .cornerRadius(30)
                                        .shadow(color: correct3 ? Color("A2A4A4") : Color("FFFFFF"), radius: 10, x: 0, y: 5)
                                        Button("\(answer4)") {
                                            if answer4 == "A part of a company" || answer4 == "A share that you buy that is a fraction" || answer4 == "The amount of money a company pays you for owning a share" {
                                            correct4 = true
                                            correct4String = "true"
                                            correct = true
                                            wrong = false
                                                if qsAnswered == 0 {
                                                    correctCount += 1
                                                    qsAnswered += 1
                                                }
                                            } else {
                                                correct1 = false
                                                correct2 = false
                                                correct3 = false
                                                correct4 = false
                                                correct4String = "false"
                                                correct = false
                                                wrong = true
                                                if qsAnswered == 0 {
                                                    qsAnswered += 1
                                                }
                                            }
                                            print("\(correctCount)/\(qsAnswered)")
                                        }
                                        .frame(width: UIScreen.main.bounds.width * 3/4)
                                        .font(.system(size: 25))
                                        .padding(.all, 10.0)
                                        .tint(Color(correct4 ? "000000" : "FFFFFF"))
                                        .background(Color(correct4 ? "A6FF91" : "007FFF"))
                                        .cornerRadius(30)
                                        .shadow(color: correct4 ? Color("A2A4A4") : Color("FFFFFF"), radius: 10, x: 0, y: 5)
                                        
                                        if correct == true {
                                            Spacer()
                                            Text("\(correctFeedback)")
                                                .font(.system(size: correct ? 22.5 : 0))
                                                .multilineTextAlignment(.center)
                                                .opacity(correct ? 1 : 0)
                                                .foregroundColor(Color("149600"))
                                            HStack {
                                                Spacer()
                                                    Text("Next")
                                                        .font(.system(size: 20))
                                                        .foregroundColor(Color("007FFF"))
                                                        .onTapGesture {
                                                            withAnimation(.spring()) {
                                                                next2.toggle()
                                                            }
                                                        }
                                                    Text("➔")
                                                        .font(.system(size: 30))
                                                        .foregroundColor(Color("007FFF"))
                                                        .onTapGesture {
                                                            withAnimation(.spring()) {
                                                                next2.toggle()
                                                            }
                                                        }
                                            }
                                    } else if wrong == true {
                                            
                                            Spacer()
                                        Text("\(wrongFeedback)")
                                                .font(.system(size: wrong ? 22.5 : 0))
                                                .multilineTextAlignment(.center)
                                                .opacity(wrong ? 1 : 0)
                                                .foregroundColor(Color("FF0057"))
                                        }
                                    }
                            .padding()
                            .background(.white)
                            .cornerRadius(30)
                            .frame(maxWidth: UIScreen.main.bounds.width * 7/8)
                            Spacer()
                        }
                        .frame(width: 400)
                        .task {
                            
                            qNum = Int.random(in: 0..<questions.count)
                            aNum = Int.random(in: 0..<answersQ0.count)
                            question1 = questions[qNum]
                            questionsTemp.append(question1)
                            questions[qNum] = ""
                            if qNum == 0 {
                                answer1 = answersQ0[aNum]
                                answersQ0Temp.append(answer1)
                                answersQ0.remove(at: aNum)
                                aNum = Int.random(in: 0..<answersQ0.count)
                                answer2 = answersQ0[aNum]
                                answersQ0Temp.append(answer2)
                                answersQ0.remove(at: aNum)
                                aNum = Int.random(in: 0..<answersQ0.count)
                                answer3 = answersQ0[aNum]
                                answersQ0Temp.append(answer3)
                                answersQ0.remove(at: aNum)
                                aNum = Int.random(in: 0..<answersQ0.count)
                                answer4 = answersQ0[aNum]
                                answersQ0Temp.append(answer4)
                                answersQ0.remove(at: aNum)
                            } else if qNum == 1 {
                                answer1 = answersQ1[aNum]
                                answersQ1Temp.append(answer1)
                                answersQ1.remove(at: aNum)
                                aNum = Int.random(in: 0..<answersQ1.count)
                                answer2 = answersQ1[aNum]
                                answersQ1Temp.append(answer2)
                                answersQ1.remove(at: aNum)
                                aNum = Int.random(in: 0..<answersQ1.count)
                                answer3 = answersQ1[aNum]
                                answersQ1Temp.append(answer3)
                                answersQ1.remove(at: aNum)
                                aNum = Int.random(in: 0..<answersQ1.count)
                                answer4 = answersQ1[aNum]
                                answersQ1Temp.append(answer4)
                                answersQ1.remove(at: aNum)
                            } else if qNum == 2 {
                                answer1 = answersQ2[aNum]
                                answersQ2Temp.append(answer1)
                                answersQ2.remove(at: aNum)
                                aNum = Int.random(in: 0..<answersQ2.count)
                                answer2 = answersQ2[aNum]
                                answersQ2Temp.append(answer2)
                                answersQ2.remove(at: aNum)
                                aNum = Int.random(in: 0..<answersQ2.count)
                                answer3 = answersQ2[aNum]
                                answersQ2Temp.append(answer3)
                                answersQ2.remove(at: aNum)
                                aNum = Int.random(in: 0..<answersQ2.count)
                                answer4 = answersQ2[aNum]
                                answersQ2Temp.append(answer4)
                                answersQ2.remove(at: aNum)
                            }
                            
                        }
                    } else {
                        
                        if !next3 {
                            
                            HStack(alignment: .center, spacing: 20) {
                                
                                Spacer()
                                        
                                        VStack(spacing: 10) {
                                            
                                            Spacer()
                                            VStack {
                                                Text("\(question2)")
                                                    
                                                    .multilineTextAlignment(.center)
                                            }
                                            .frame(maxWidth: .infinity)
                                            Spacer()
                                            Button("\(answer1)") {
                                                if answer1 == "A part of a company" || answer1 == "A share that you buy that is a fraction" || answer1 == "The amount of money a company pays you for owning a share" {
                                                    correct1 = true
                                                    correct1String = "true"
                                                    correct = true
                                                    wrong = false
                                                    if qsAnswered == 1 {
                                                        correctCount += 1
                                                        qsAnswered += 1
                                                    }
                                                } else {
                                                    correct1 = false
                                                    correct2 = false
                                                    correct3 = false
                                                    correct4 = false
                                                    correct1String = "false"
                                                    correct = false
                                                    wrong = true
                                                    if qsAnswered == 1 {
                                                        qsAnswered += 1
                                                    }
                                                }
                                                print("\(correctCount)/\(qsAnswered)")
                                            }
                                            .frame(width: UIScreen.main.bounds.width * 3/4)
                                            .padding(.all, 10.0)
                                            .tint(Color(correct1 ? "000000" : "FFFFFF"))
                                            .background(Color(correct1 ? "A6FF91" : "007FFF"))
                                            .cornerRadius(30)
                                            .shadow(color: Color(correct1 ? "A2A4A4" : "FFFFFF"), radius: 10, x: 0, y: 5)
                                            Button("\(answer2)") {
                                                if answer2 == "A part of a company" || answer2 == "A share that you buy that is a fraction" || answer2 == "The amount of money a company pays you for owning a share" {
                                                    correct2 = true
                                                    correct2String = "true"
                                                    correct = true
                                                    wrong = false
                                                    if qsAnswered == 1 {
                                                        correctCount += 1
                                                        qsAnswered += 1
                                                    }
                                                } else {
                                                    correct1 = false
                                                    correct2 = false
                                                    correct3 = false
                                                    correct4 = false
                                                    correct2String = "false"
                                                    correct = false
                                                    wrong = true
                                                    if qsAnswered == 1 {
                                                        qsAnswered += 1
                                                    }
                                                }
                                                print("\(correctCount)/\(qsAnswered)")
                                            }
                                            .frame(width: UIScreen.main.bounds.width * 3/4)
                                            .padding(.all, 10.0)
                                            .tint(Color(correct2 ? "000000" : "FFFFFF"))
                                            .background(Color(correct2 ? "A6FF91" : "007FFF"))
                                            .cornerRadius(30)
                                            .shadow(color: Color(correct2 ? "A2A4A4" : "FFFFFF"), radius: 10, x: 0, y: 5)
                                            Button("\(answer3)") {
                                                if answer3 == "A part of a company" || answer3 == "A share that you buy that is a fraction" || answer3 == "The amount of money a company pays you for owning a share" {
                                                    correct3 = true
                                                    correct3String = "true"
                                                    correct = true
                                                    wrong = false
                                                    if qsAnswered == 1 {
                                                        correctCount += 1
                                                        qsAnswered += 1
                                                    }
                                                } else {
                                                    correct1 = false
                                                    correct2 = false
                                                    correct3 = false
                                                    correct4 = false
                                                    correct3String = "false"
                                                    correct = false
                                                    wrong = true
                                                    if qsAnswered == 1 {
                                                        qsAnswered += 1
                                                    }
                                                }
                                                print("\(correctCount)/\(qsAnswered)")
                                            }
                                            .frame(width: UIScreen.main.bounds.width * 3/4)
                                            .padding(.all, 10.0)
                                            .tint(Color(correct3 ? "000000" : "FFFFFF"))
                                            .background(Color(correct3 ? "A6FF91" : "007FFF"))
                                            .cornerRadius(30)
                                            .shadow(color: Color(correct3 ? "A2A4A4" : "FFFFFF"), radius: 10, x: 0, y: 5)
                                            Button("\(answer4)") {
                                                if answer4 == "A part of a company" || answer4 == "A share that you buy that is a fraction" || answer4 == "The amount of money a company pays you for owning a share" {
                                                correct4 = true
                                                correct4String = "true"
                                                correct = true
                                                wrong = false
                                                    if qsAnswered == 1 {
                                                        correctCount += 1
                                                        qsAnswered += 1
                                                    }
                                                } else {
                                                    correct1 = false
                                                    correct2 = false
                                                    correct3 = false
                                                    correct4 = false
                                                    correct4String = "false"
                                                    correct = false
                                                    wrong = true
                                                    if qsAnswered == 1 {
                                                        qsAnswered += 1
                                                    }
                                                }
                                                print("\(correctCount)/\(qsAnswered)")
                                            }
                                            .frame(width: UIScreen.main.bounds.width * 3/4)
                                            .padding(.all, 10.0)
                                            .tint(Color(correct4 ? "000000" : "FFFFFF"))
                                            .background(Color(correct4 ? "A6FF91" : "007FFF"))
                                            .cornerRadius(30)
                                            .shadow(color: Color(correct4 ? "A2A4A4" : "FFFFFF"), radius: 10, x: 0, y: 5)
                                            if correct == true {
                                                Spacer()
                                                Text("\(correctFeedback)")
                                                    .font(.system(size: correct ? 22.5 : 0))
                                                    .multilineTextAlignment(.center)
                                                    .opacity(correct ? 1 : 0)
                                                    .foregroundColor(Color("149600"))
                                                HStack {
                                                    Spacer()
                                                        Text("Next")
                                                            .font(.system(size: 20))
                                                            .foregroundColor(Color("007FFF"))
                                                            .onTapGesture {
                                                                withAnimation(.spring()) {
                                                                    next3.toggle()
                                                                }
                                                            }
                                                        Text("➔")
                                                            .font(.system(size: 30))
                                                            .foregroundColor(Color("007FFF"))
                                                            .onTapGesture {
                                                                withAnimation(.spring()) {
                                                                    next3.toggle()
                                                                }
                                                            }
                                                }
                                        } else if wrong == true {
                                            Spacer()
                                            Text("\(wrongFeedback)")
                                                .font(.system(size: wrong ? 22.5 : 0))
                                                .multilineTextAlignment(.center)
                                                .opacity(wrong ? 1 : 0)
                                                .foregroundColor(Color("FF0057"))
                                        }
                                        }
                                .padding()
                                .background(.white)
                                .cornerRadius(30)
                                .frame(maxWidth: UIScreen.main.bounds.width * 7/8)
                                
                                Spacer()
                            }
                            .frame(width: 400)
                            .task {
                                
                                answer1 = ""
                                answer2 = ""
                                answer3 = ""
                                answer4 = ""
                                question2 = ""
                                question3 = ""
                                correct1 = false
                                correct2 = false
                                correct3 = false
                                correct4 = false
                                correct = false
                                wrong = false
                                correct1String = ""
                                correct2String = ""
                                correct3String = ""
                                correct4String = ""
                                qNum = Int.random(in: 0..<questions.count)
                                aNum = Int.random(in: 0...3)
                                while questions[qNum] == "" {
                                    qNum = Int.random(in: 0..<questions.count)
                                }
                                question2 = questions[qNum]
                                questionsTemp.append(question2)
                                questions[qNum] = ""
                                if qNum == 0 {
                                    answer1 = answersQ0[aNum]
                                    answersQ0Temp.append(answer1)
                                    answersQ0.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ0.count)
                                    answer2 = answersQ0[aNum]
                                    answersQ0Temp.append(answer2)
                                    answersQ0.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ0.count)
                                    answer3 = answersQ0[aNum]
                                    answersQ0Temp.append(answer3)
                                    answersQ0.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ0.count)
                                    answer4 = answersQ0[aNum]
                                    answersQ0Temp.append(answer4)
                                    answersQ0.remove(at: aNum)
                                } else if qNum == 1 {
                                    answer1 = answersQ1[aNum]
                                    answersQ1Temp.append(answer1)
                                    answersQ1.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ1.count)
                                    answer2 = answersQ1[aNum]
                                    answersQ1Temp.append(answer2)
                                    answersQ1.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ1.count)
                                    answer3 = answersQ1[aNum]
                                    answersQ1Temp.append(answer3)
                                    answersQ1.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ1.count)
                                    answer4 = answersQ1[aNum]
                                    answersQ1Temp.append(answer4)
                                    answersQ1.remove(at: aNum)
                                } else if qNum == 2 {
                                    answer1 = answersQ2[aNum]
                                    answersQ2Temp.append(answer1)
                                    answersQ2.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ2.count)
                                    answer2 = answersQ2[aNum]
                                    answersQ2Temp.append(answer2)
                                    answersQ2.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ2.count)
                                    answer3 = answersQ2[aNum]
                                    answersQ2Temp.append(answer3)
                                    answersQ2.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ2.count)
                                    answer4 = answersQ2[aNum]
                                    answersQ2Temp.append(answer4)
                                    answersQ2.remove(at: aNum)
                                }
                                
                            }
                            .transition(.move(edge: .trailing))
                            .zIndex(2)
                        } else {
                            
                            HStack(alignment: .center, spacing: 20) {
                                
                                Spacer()
                                        
                                        VStack(spacing: 10) {
                                            
                                            Spacer()
                                            VStack {
                                                Text("\(question3)")
                                                    
                                                    .multilineTextAlignment(.center)
                                            }
                                            .frame(maxWidth: .infinity)
                                            Spacer()
                                            Button("\(answer1)") {
                                                if answer1 == "A part of a company" || answer1 == "A share that you buy that is a fraction" || answer1 == "The amount of money a company pays you for owning a share" {
                                                    correct1 = true
                                                    correct1String = "true"
                                                    correct = true
                                                    wrong = false
                                                    if qsAnswered == 2 {
                                                        correctCount += 1
                                                        qsAnswered += 1
                                                    }
                                                } else {
                                                    correct1 = false
                                                    correct2 = false
                                                    correct3 = false
                                                    correct4 = false
                                                    correct1String = "false"
                                                    correct = false
                                                    wrong = true
                                                    if qsAnswered == 2 {
                                                        qsAnswered += 1
                                                    }
                                                }
                                                print("\(correctCount)/\(qsAnswered)")
                                            }
                                            .frame(width: UIScreen.main.bounds.width * 3/4)
                                            
                                            
                                            .padding(.all, 10.0)
                                            .tint(Color(correct1 ? "000000" : "FFFFFF"))
                                            .background(Color(correct1 ? "A6FF91" : "007FFF"))
                                            .cornerRadius(30)
                                            .shadow(color: Color(correct1 ? "A2A4A4" : "FFFFFF"), radius: 10, x: 0, y: 5)
                                            Button("\(answer2)") {
                                                if answer2 == "A part of a company" || answer2 == "A share that you buy that is a fraction" || answer2 == "The amount of money a company pays you for owning a share" {
                                                    correct2 = true
                                                    correct2String = "true"
                                                    correct = true
                                                    wrong = false
                                                    if qsAnswered == 2 {
                                                        correctCount += 1
                                                        qsAnswered += 1
                                                    }
                                                } else {
                                                    correct1 = false
                                                    correct2 = false
                                                    correct3 = false
                                                    correct4 = false
                                                    correct1String = "false"
                                                    correct = false
                                                    wrong = true
                                                    if qsAnswered == 2 {
                                                        qsAnswered += 1
                                                    }
                                                }
                                                print("\(correctCount)/\(qsAnswered)")
                                            }
                                            .frame(width: UIScreen.main.bounds.width * 3/4)
                                            
                                            
                                            .padding(.all, 10.0)
                                            .tint(Color(correct2 ? "000000" : "FFFFFF"))
                                            .background(Color(correct2 ? "A6FF91" : "007FFF"))
                                            .cornerRadius(30)
                                            .shadow(color: Color(correct2 ? "A2A4A4" : "FFFFFF"), radius: 10, x: 0, y: 5)
                                            Button("\(answer3)") {
                                                if answer3 == "A part of a company" || answer3 == "A share that you buy that is a fraction" || answer3 == "The amount of money a company pays you for owning a share" {
                                                    correct3 = true
                                                    correct3String = "true"
                                                    correct = true
                                                    wrong = false
                                                    if qsAnswered == 2 {
                                                        correctCount += 1
                                                        qsAnswered += 1
                                                    }
                                                } else {
                                                    correct1 = false
                                                    correct2 = false
                                                    correct3 = false
                                                    correct4 = false
                                                    correct1String = "false"
                                                    correct = false
                                                    wrong = true
                                                    if qsAnswered == 2 {
                                                        qsAnswered += 1
                                                    }
                                                }
                                                print("\(correctCount)/\(qsAnswered)")
                                            }
                                            .frame(width: UIScreen.main.bounds.width * 3/4)
                                            
                                            
                                            .padding(.all, 10.0)
                                            .tint(Color(correct3 ? "000000" : "FFFFFF"))
                                            .background(Color(correct3 ? "A6FF91" : "007FFF"))
                                            .cornerRadius(30)
                                            .shadow(color: Color(correct3 ? "A2A4A4" : "FFFFFF"), radius: 10, x: 0, y: 5)
                                            Button("\(answer4)") {
                                                if answer4 == "A part of a company" || answer4 == "A share that you buy that is a fraction" || answer4 == "The amount of money a company pays you for owning a share" {
                                                correct4 = true
                                                correct4String = "true"
                                                correct = true
                                                wrong = false
                                                    if qsAnswered == 2 {
                                                        correctCount += 1
                                                        qsAnswered += 1
                                                    }
                                                } else {
                                                    correct1 = false
                                                    correct2 = false
                                                    correct3 = false
                                                    correct4 = false
                                                    correct1String = "false"
                                                    correct = false
                                                    wrong = true
                                                    if qsAnswered == 2 {
                                                        qsAnswered += 1
                                                    }
                                                }
                                                print("\(correctCount)/\(qsAnswered)")
                                            }
                                            .frame(width: UIScreen.main.bounds.width * 3/4)
                                            
                                            
                                            .padding(.all, 10.0)
                                            .tint(Color(correct4 ? "000000" : "FFFFFF"))
                                            .background(Color(correct4 ? "A6FF91" : "007FFF"))
                                            .cornerRadius(30)
                                            .shadow(color: Color(correct4 ? "A2A4A4" : "FFFFFF"), radius: 10, x: 0, y: 5)
                                            if correct == true {
                                                Spacer()
                                                Text("\(correctFeedback)")
                                                    .font(.system(size: correct ? 22.5 : 0))
                                                    .multilineTextAlignment(.center)
                                                    .opacity(correct ? 1 : 0)
                                                    .foregroundColor(Color("149600"))
                                                HStack {
                                                    Spacer()
                                                    Button {
                                                        dismiss()
                                                    } label: {
                                                        Text("\(correctCount)/\(qsAnswered) Correct")
                                                            .font(.system(size: 20))
                                                            .foregroundColor(Color("000000"))
                                                        Spacer()
                                                        Text("Article")
                                                            .font(.system(size: 20))
                                                            .foregroundColor(Color("007FFF"))
                                                        Text("➔")
                                                            .font(.system(size: 30))
                                                            .foregroundColor(Color("007FFF"))
                                                    }
                                                }
                                        } else if wrong == true {
                                            Spacer()
                                            Text("\(wrongFeedback)")
                                                .font(.system(size: wrong ? 22.5 : 0))
                                                .multilineTextAlignment(.center)
                                                .opacity(wrong ? 1 : 0)
                                                .foregroundColor(Color("FF0057"))
                                        }
                                        }
                                .padding()
                                .background(.white)
                                .cornerRadius(30)
                                .frame(maxWidth: UIScreen.main.bounds.width * 7/8)
                                
                                Spacer()
                            }
                            .frame(width: 400)
                            .task {
                                
                                correct1 = false
                                correct2 = false
                                correct3 = false
                                correct4 = false
                                correct = false
                                wrong = false
                                correct1String = ""
                                correct2String = ""
                                correct3String = ""
                                correct4String = ""
                                qNum = 0
                                aNum = 0
                                answer1 = ""
                                answer2 = ""
                                answer3 = ""
                                answer4 = ""
                                question3 = ""
                                qNum = Int.random(in: 0..<questions.count)
                                aNum = Int.random(in: 0...3)
                                while questions[qNum] == "" {
                                    qNum = Int.random(in: 0..<questions.count)
                                }
                                question3 = questions[qNum]
                                questionsTemp.append(question3)
                                questions[qNum] = ""
                                if qNum == 0 {
                                    answer1 = answersQ0[aNum]
                                    answersQ0Temp.append(answer1)
                                    answersQ0.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ0.count)
                                    answer2 = answersQ0[aNum]
                                    answersQ0Temp.append(answer2)
                                    answersQ0.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ0.count)
                                    answer3 = answersQ0[aNum]
                                    answersQ0Temp.append(answer3)
                                    answersQ0.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ0.count)
                                    answer4 = answersQ0[aNum]
                                    answersQ0Temp.append(answer4)
                                    answersQ0.remove(at: aNum)
                                } else if qNum == 1 {
                                    answer1 = answersQ1[aNum]
                                    answersQ1Temp.append(answer1)
                                    answersQ1.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ1.count)
                                    answer2 = answersQ1[aNum]
                                    answersQ1Temp.append(answer2)
                                    answersQ1.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ1.count)
                                    answer3 = answersQ1[aNum]
                                    answersQ1Temp.append(answer3)
                                    answersQ1.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ1.count)
                                    answer4 = answersQ1[aNum]
                                    answersQ1Temp.append(answer4)
                                    answersQ1.remove(at: aNum)
                                } else if qNum == 2 {
                                    answer1 = answersQ2[aNum]
                                    answersQ2Temp.append(answer1)
                                    answersQ2.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ2.count)
                                    answer2 = answersQ2[aNum]
                                    answersQ2Temp.append(answer2)
                                    answersQ2.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ2.count)
                                    answer3 = answersQ2[aNum]
                                    answersQ2Temp.append(answer3)
                                    answersQ2.remove(at: aNum)
                                    aNum = Int.random(in: 0..<answersQ2.count)
                                    answer4 = answersQ2[aNum]
                                    answersQ2Temp.append(answer4)
                                    answersQ2.remove(at: aNum)
                                }
                                
                            }
                            .transition(.move(edge: .trailing))
                            .zIndex(4)
                        }
                    }
                    
                    
                }
                .navigationBarBackButtonHidden(true)
            }
        }
}


#Preview {
    Quiz2()
}
