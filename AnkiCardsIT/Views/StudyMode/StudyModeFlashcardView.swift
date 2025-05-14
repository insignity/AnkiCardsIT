import SwiftUI

struct StudyModeFlashcardView: View {
    // MARK: - Constants
    private enum Constants {
        static let cardWidth: CGFloat = 300
        static let cardHeight: CGFloat = 180
        static let cornerRadius: CGFloat = 16
        static let animationDuration: Double = 0.4
        static let shadowRadius: CGFloat = 5
        static let perspective: CGFloat = 0.5
        static let minScaleFactor: CGFloat = 0.8
    }
    
    // MARK: - Properties
    var flashcard: FlashcardModel
    @Binding var didSeeAnswer: Bool
    @Binding var isFlipped: Bool
    @State private var flipRotation = 0.0
    @State private var isAnimating = false
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Initialization
    init(flashcard: FlashcardModel, didSeeAnswer: Binding<Bool>, isFlipped: Binding<Bool>, flipRotation: Double = 0.0) {
        self.flashcard = flashcard
        self._didSeeAnswer = didSeeAnswer
        self._isFlipped = isFlipped
        self._flipRotation = State(initialValue: flipRotation)
    }

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            let scale = min(geometry.size.width / Constants.cardWidth, 
                          geometry.size.height / Constants.cardHeight,
                          Constants.minScaleFactor)
            
            ZStack {
                // Front Side
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color(.systemRed))
                    .shadow(radius: Constants.shadowRadius)
                    .frame(width: Constants.cardWidth, height: Constants.cardHeight)
                    .overlay(
                        Text(flashcard.front)
                            .font(.title)
                            .foregroundColor(.white)
                            .minimumScaleFactor(Constants.minScaleFactor)
                            .lineLimit(5)
                            .padding()
                    )
                    .opacity(isFlipped ? 0.0 : 1.0)
                    .accessibilityLabel("Flashcard Front: \(flashcard.front)")

                // Back Side
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color(.systemBlue))
                    .shadow(radius: Constants.shadowRadius)
                    .frame(width: Constants.cardWidth, height: Constants.cardHeight)
                    .overlay(
                        Text(flashcard.back)
                            .font(.title)
                            .foregroundColor(.white)
                            .minimumScaleFactor(Constants.minScaleFactor)
                            .lineLimit(5)
                            .padding()
                    )
                    .opacity(isFlipped ? 1.0 : 0.0)
                    .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                    .accessibilityLabel("Flashcard Back: \(flashcard.back)")
            }
            .rotation3DEffect(.degrees(flipRotation), axis: (x: 1, y: 0, z: 0), perspective: Constants.perspective)
            .scaleEffect(scale)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .onTapGesture {
                guard !isAnimating else { return }
                if !didSeeAnswer {
                    didSeeAnswer = true
                }
                flipCard()
            }
            .accessibilityHint(isFlipped ? "Double tap to flip back" : "Double tap to reveal answer")
            .accessibilityAddTraits(.isButton)
        }
    }

    // MARK: - Private Methods
    private func flipCard() {
        isAnimating = true
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            flipRotation += 180
            isFlipped.toggle()
        } completion: {
            isAnimating = false
        }
    }
}
