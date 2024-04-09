//
//  EmojiView.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/7/24.
//

import SwiftUI

public struct EmojiPickerView: View {
    @Environment(\.dismiss)
    var dismiss

    @Binding
    public var selectedEmoji: Emoji

    @State
    private var search: String = ""
    private var selectedColor: Color
    private var searchEnabled: Bool
    @State private var searchIsPresent: Bool

    public init(selectedEmoji: Binding<Emoji>, searchEnabled: Bool = true, searchIsPresent: Bool = true, selectedColor: Color = .black, emojiProvider: EmojiProvider = CustomEmojiProvider()) {
        self._selectedEmoji = selectedEmoji
        self.selectedColor = selectedColor
        self.searchEnabled = searchEnabled
        self.searchIsPresent = searchIsPresent
        self.emojis = emojiProvider.getAll()
    }

    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]

    let emojis: [Emoji]

    private var searchResults: [Emoji] {
        if search.isEmpty {
            return emojis
        } else {
            return emojis
                .filter { $0.name.lowercased().contains(search.lowercased()) }
        }
    }

    public var body: some View {
        ZStack {
            BlurBackgroundView(effect: UIBlurEffect(style: .dark))
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(searchResults, id: \.self) { emoji in
                        RoundedRectangle(cornerRadius: 10)
                            .fill((selectedEmoji == emoji ? selectedColor : Color.gray).opacity(0.4))
                            .frame(width: 54, height: 54)
                            .overlay {
                                Text(emoji.value)
                                    .font(.largeTitle)
                            }
                            .onTapGesture {
                                selectedEmoji = emoji
                                dismiss()
                            }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: .infinity)
            .searchable(text: $search, isPresented: $searchIsPresent)
            .preferredColorScheme(.dark)
        }
    }
}

struct EmojiPickerView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPickerView(selectedEmoji: .constant(Emoji(value: "", name: "", keywords: [])))
    }
}


