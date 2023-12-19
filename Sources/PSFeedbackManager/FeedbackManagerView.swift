//
//  FeedbackManagerView.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import SwiftUI
import PhotosUI
import MessageUI
import UIKit

public struct FeedbackManagerView: View {

    public init(configuration: Configuration) {
        self.configuration = configuration
    }

    public var configuration: Configuration

    @Environment(\.dismiss)
    private var dismiss

    @FocusState
    private var isTextFieldFocused: Bool

    @State
    var state: EditState = .vanilla

    @State
    private var text: String = ""

    @State
    private var selectedTopic: Topic = .question

    @State
    private var selectedPhotoItems: [PhotosPickerItem] = []

    @State
    private var selectedAttachmentImages: [UIImage] = []

    @State
    private var showMailView: Bool = false

    @State
    private var showMailErrorAlert: Bool = false

    @State
    private var email = EmailModel()

    public var body: some View {
        
        NavigationStack {

            Color(.systemGroupedBackground)
                .ignoresSafeArea()
                .overlay {

                    VStack {

                        if configuration.isModal, state == .edited {

                            HStack {
                                Spacer()
                                Text(Strings.editedNotification)
                                Spacer()
                            }
                            .foregroundStyle(.secondary)
                            .padding()
                            .background(.thickMaterial)
                        }

                        Form {

                            // Section for "Topic"
                            topicSection

                            // Section for "Attachments"
                            attachmentsSection

                            // Section for "Device Info"
                            deviceInfoSection

                            // Section for "App Info"
                            appInfoSection
                        }
                        .scrollDismissesKeyboard(.interactively)
                        .interactiveDismissDisabled(
                            configuration.isModal && state != .vanilla
                        )
                        .onChange(of: selectedPhotoItems) { selectedPhotoItems in

                            withAnimation {
                                state = .edited
                            }

                            Task {
                                selectedAttachmentImages.removeAll()

                                for item in selectedPhotoItems {

                                    if let imageData = try? await item.loadTransferable(type: Data.self),
                                       let image = UIImage(data: imageData) {

                                        withAnimation {
                                            selectedAttachmentImages.append(image)
                                        }
                                    }
                                }
                            }
                        }
                        .onChange(of: text) { _ in
                            withAnimation {
                                state = .edited
                            }
                        }
                        .sheet(isPresented: $showMailView) {
                            MailView(
                                data: $email,
                                callback: { result in

                                    guard configuration.isModal else {
                                        return
                                    }

                                    switch result {

                                    case .success(let composeResult):
                                        switch composeResult {

                                        case .sent:
                                            dismiss()

                                        default:
                                            break
                                        }

                                    case .failure:
                                        break
                                    }
                                }
                            )
                        }
                        .alert(
                            Strings.alertMailUnavailableTitle,
                            isPresented: $showMailErrorAlert,
                            actions: {
                                Button(
                                    Strings.okAction,
                                    role: .cancel,
                                    action: {}
                                )
                            },
                            message: {
                                Text(
                                    String.localizedStringWithFormat(
                                        Strings.alertMailUnavailableMessageFormat,
                                        configuration.recipients.first ?? ""
                                    )
                                )
                            }
                        )
                    }
                }
                .navigationTitle(configuration.title)
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    if configuration.isModal {

                        ToolbarItem(placement: .topBarLeading) {
                            Button(configuration.cancelButtonTitle) {
                                dismiss()
                            }
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button(configuration.sendButtonTitle, action: sendEmail)
                    }
                }
        }
    }
}

// MARK: - Theme Section

extension FeedbackManagerView {

    @ViewBuilder
    var topicSection: some View {
        
        Section(Strings.headerTopic) {

            Picker(Strings.topicSelectTitle, selection: $selectedTopic) {
                ForEach(Topic.allCases) {
                    Label($0.name, systemImage: $0.symbolName)
                        .tag($0)
                }
            }

            VStack(alignment: .leading) {

                HStack {
                    Text(
                        String.localizedStringWithFormat(
                            Strings.textViewPlaceholderWithSelection,
                            selectedTopic.name.lowercased()
                        )
                    )
                    .foregroundStyle(.secondary)

                    Spacer()

                    Button(
                        action: {
                            text = ""
                        },
                        label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                        }
                    )
                    .disabled(text.isEmpty)
                }

                TextEditor(text: $text)
                    .lineLimit(10, reservesSpace: true)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
                    .frame(minHeight: 100)
                    .focused($isTextFieldFocused)
                    .toolbar {
                        // Done button on top of the keyboard.
                        ToolbarItemGroup(placement: .keyboard) {

                            Spacer()

                            Button(
                                action: { isTextFieldFocused = false },
                                label: {
                                    Image(systemName: "keyboard.chevron.compact.down.fill")
                                }
                            )
                            .foregroundStyle(Color.accentColor)
                        }
                    }
            }
        }
    }
}

// MARK: - Attachments Section

extension FeedbackManagerView {

    @ViewBuilder
    var attachmentsSection: some View {

        Section(Strings.headerAttachments) {

            if !selectedAttachmentImages.isEmpty {

                ListShelfSection(
                    title: { EmptyView() },
                    content: {
                        Group {
                            ForEach(0..<selectedAttachmentImages.count, id: \.self) { idx in

                                ListCard {
                                    Image(uiImage: selectedAttachmentImages[idx])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .overlay(alignment: .bottomTrailing) {
                                            Button(
                                                role: .destructive,
                                                action: {
                                                    deleteAttachment(at: idx)
                                                },
                                                label: {
                                                    Image(systemName: "trash")
                                                }
                                            )
                                            .font(.title2)
                                            .padding(8)
                                            .background(.thinMaterial)
                                            .clipShape(Circle())
                                            .padding(.bottom, 2)
                                            .padding(.trailing, 2)
                                        }
                                }
                            }
                        }
                    }
                )
            }

            PhotosPicker(
                selection: $selectedPhotoItems,
                maxSelectionCount: 5,
                matching: .images,
                preferredItemEncoding: .automatic,
                label: {
                    HStack {
                        Text(Strings.attachmentsAttachTitle)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                }
            )
        }
    }
}

// MARK: - Device Info Section

extension FeedbackManagerView {

    @ViewBuilder
    var deviceInfoSection: some View {
        
        Section(Strings.headerDeviceInfo) {

            HStack {
                Text(Strings.deviceInfoDeviceTitle)
                Spacer()
                Text(email.deviceModel)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Text(Strings.deviceInfoSystemTitle)
                Spacer()
                Text(email.deviceOS)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - App Info Section

extension FeedbackManagerView {

    @ViewBuilder
    var appInfoSection: some View {
        
        Section(Strings.headerAppInfo) {

            HStack {
                Text(Strings.appInfoNameTitle)
                Spacer()
                Text(email.appName)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Text(Strings.appInfoVersionTitle)
                Spacer()
                Text(email.appVersion)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Text(Strings.appInfoBuildTitle)
                Spacer()
                Text(email.appBuild)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Methods

extension FeedbackManagerView {

    private func sendEmail() {
        
        var idx = 0
        email.attachments = selectedAttachmentImages.map {

            idx += 1

            return AttachmentData(
                data: $0.jpegData(compressionQuality: 0.8)!,
                mimeType: "image/jpeg",
                fileName: "attachment\(idx).jpeg"
            )
        }
        email.subject = "\(email.appName) - \(selectedTopic.name)"
        email.body = text
        email.recipients = configuration.recipients

        composeEmail()
    }

    private func deleteAttachment(at idx: Int) {

        guard idx >= 0, idx < selectedPhotoItems.count else {
            return
        }

        selectedPhotoItems.remove(at: idx)
    }

    private func composeEmail() {
        
        let info = "Device: \(email.deviceModel)\n"
            + "iOS: \(email.deviceOS)\n"
            + "App Name: \(email.appName)\n"
            + "App Version: \(email.appVersion)\n"
            + "App Build: \(email.appBuild)\n"

        let body = "\(email.body)\n\n" + info

        guard MailView.canSendMail else {

            if let subject = email.subject.addingPercentEncoding(
                    withAllowedCharacters: .urlHostAllowed
               ),
               let bodyEncoded = body.addingPercentEncoding(
                    withAllowedCharacters: .urlHostAllowed
               ),
               let recipient = email.recipients.first,
               let url = URL(
                    string: "mailto:\(recipient)?subject=\(subject)&body=\(bodyEncoded)"
               ),
               UIApplication.shared.canOpenURL(url) {

                UIApplication.shared.open(
                    url,
                    options: [:],
                    completionHandler: nil
                )

            } else {
                showMailErrorAlert = true
            }

            return
        }

        email.body = body

        showMailView = true
    }
}

// MARK: - Data Types

extension FeedbackManagerView {

    enum EditState {

        case vanilla
        case edited
    }

    enum Topic: CaseIterable, Identifiable {

        var id: String { name }

        case question
        case request
        case bugReport
        case other

        var symbolName: String {

            switch self {
            
            case .question:
                "questionmark.circle.fill"

            case .request:
                "info.circle.fill"

            case .bugReport:
                "ant.circle.fill"

            case .other:
                "ellipsis.circle.fill"
            }
        }

        var name: String {

            switch self {
            
            case .question:
                Strings.topicSelectionQuestion

            case .request:
                Strings.topicSelectionRequest

            case .bugReport:
                Strings.topicSelectionBugReport

            case .other:
                Strings.topicSelectionOther
            }
        }
    }
}

#Preview {
    FeedbackManagerView(configuration: .init(recipients: ["test@email.com"]))
}

#Preview {
    FeedbackManagerView(
        configuration: .init(isModal: false, recipients: ["test@email.com"])
    )
}
