//
//  ListActions.swift
//  WWDC21SwifUI
//
//  Created by Milos Malovic on 9.6.21..
//

import SwiftUI

@available(iOS 15.0, *)
struct ListActions: View {

    @State private var stories = StoryChar(Story.preview)

    var body: some View {
        NavigationView {
            List {
                if !stories.pinned.isEmpty {
                    Section("Pinned") {
                        sectionContent(for: $stories.pinned)
                    }
                }
                Section("Unpinned") {
                    sectionContent(for: $stories.unpinned)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Characters")
        }
    }

    @ViewBuilder
    private func sectionContent(for stories: Binding<[Story]>) -> some View {
        ForEach(stories) { $story in
            VStack {
                Text(story.title)
                    .font(.title3)
                Text(story.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .swipeActions {
                Button {
                    withAnimation {
                        story.pinned.toggle()
                    }
                } label: {
                    if story.pinned {
                        Label("Unpin", systemImage: "pin.slash")
                    } else {
                        Label("Pin", systemImage: "pin")
                    }
                }
                .tint(.purple)
            }
        }
    }
}


fileprivate struct Story: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var pinned: Bool
    var lastModified: Date = Date()

    static var preview: [Story] = [
        Story(title: "Lorem 1", description: "description1", pinned: false),
        Story(title: "Lorem 2", description: "description2", pinned: false),
        Story(title: "Lorem 3", description: "description3", pinned: true),
        Story(title: "Lorem 4", description: "description4", pinned: false),
        Story(title: "Lorem 5", description: "description5", pinned: true),
        Story(title: "Lorem 6", description: "description6", pinned: false)
    ]
}


fileprivate struct StoryChar {
    var all: [Story] {
        get { _all }
        set { _all = newValue; sortAll() }
    }
    var _all: [Story]

    var pinned: [Story] {
        get {
            all.prefix { $0.pinned }
        }
        set {
            if let end = all.firstIndex(where: { !$0.pinned }) {
                all.replaceSubrange(all.startIndex..<end, with: newValue)
            }
        }
    }

    var unpinned: [Story] {
        get {
            if let start = all.firstIndex(where: { !$0.pinned }) {
                return Array(all.suffix(from: start))
            } else {
                return []
            }
        }
        set {
            if let start = all.firstIndex(where: { !$0.pinned }) {
                all.replaceSubrange(start..<all.endIndex, with: newValue)
            }
        }
    }
    init(_ story: [Story]) {
        _all = story
        sortAll()
    }

    private mutating func sortAll() {
        _all.sort { lhs, rhs in
            if lhs.pinned && !rhs.pinned {
                return true
            } else if !lhs.pinned && rhs.pinned {
                return false
            } else {
                return lhs.lastModified < rhs.lastModified
            }
        }
    }
}

