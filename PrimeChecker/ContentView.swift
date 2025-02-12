// Student Name: Anar Samadzade
// Student ID: 101391879

import SwiftUI

struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...100)
    @State private var isCorrect: Bool?
    @State private var correctCount: Int = 0
    @State private var wrongCount: Int = 0
    @State private var attempts: Int = 0
    @State private var showAlert: Bool = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("Is this number prime?")
                .font(.title)
                .padding()
            
            Text("\(number)")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.blue)
                .padding()
            
            HStack {
                Button("Prime") {
                    checkAnswer(isPrime: true)
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Button("Not Prime") {
                    checkAnswer(isPrime: false)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
            if let correct = isCorrect {
                Text(correct ? "✅ Correct" : "❌ Wrong")
                    .font(.largeTitle)
                    .foregroundColor(correct ? .green : .red)
                    .padding()
            }
        }
        .onAppear {
            startTimer()
        }
        .alert("Results", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                attempts = 0
            }
        } message: {
            Text("Correct: \(correctCount)\nWrong: \(wrongCount)")
        }
    }
    
    // Function to check if a number is prime
    func isPrime(_ num: Int) -> Bool {
        guard num > 1 else { return false }
        for i in 2..<num {
            if num % i == 0 {
                return false
            }
        }
        return true
    }
    
    // Function to check the answer
    func checkAnswer(isPrime: Bool) {
        if isPrime == self.isPrime(number) {
            isCorrect = true
            correctCount += 1
        } else {
            isCorrect = false
            wrongCount += 1
        }
        
        attempts += 1
        if attempts == 10 {
            showAlert = true
        }
        
        number = Int.random(in: 1...100) // Generate a new number
    }
    
    // Timer to update the number every 5 seconds
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            isCorrect = false
            wrongCount += 1 // If the user doesn't answer, it's recorded as a wrong attempt
            attempts += 1
            number = Int.random(in: 1...100)
            
            if attempts == 10 {
                showAlert = true
            }
        }
    }
}
