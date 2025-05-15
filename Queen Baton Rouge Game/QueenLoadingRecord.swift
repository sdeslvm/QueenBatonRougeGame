import SwiftUI

struct LambdaProgressView: View {
    var progress: Double

    var body: some View {
        ZStack {
            // Твой фон
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Затемнение для улучшения читаемости
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()

            // Контент в центре экрана
            VStack(spacing: 40) {
                // Логотип сверху
                Image("title")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top, 40)

                // Блок с текстом и прогресс-баром
                VStack(spacing: 20) {
                    // Белый блок с текстом и тенью
                    Text("Loading: \(Int(progress * 100))%")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(Color.white)
                                .shadow(radius: 6)
                        )

                    // Прогресс-бар
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 12)
                            .foregroundColor(.white.opacity(0.2))
                            .cornerRadius(6)

                        Rectangle()
                            .frame(width: CGFloat(progress) * 300, height: 12)
                            .foregroundColor(.green)
                            .cornerRadius(6)
                            .animation(.easeOut(duration: 0.3), value: progress)
                    }
                    .frame(width: 300)
                }

                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    LambdaProgressView(progress: 0.4)
}
