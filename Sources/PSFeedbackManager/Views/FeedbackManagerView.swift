//
//  FeedbackManagerView.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import SwiftUI
import PhotosUI
import MessageUI

/**
 TODO
 */
public struct FeedbackManagerView: View {

    public init(configuration: Configuration) {
        self.configuration = configuration
    }

    public var configuration: Configuration

    @Environment(\.dismiss)
    private var dismiss

    @FocusState
    private var isTextFieldFocused: Bool

    /// Whether the user already started creating a report  (`.edited`) or not (`.vanilla`).
    @State
    private var state: EditState = .vanilla

    /// The text entered by the user.
    @State
    private var text: String = ""

    /// The topic selected by the user.
    @State
    private var selectedTopic: Topic = .question

    /// Internal representation of selected attachment images.
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

        // This is necessary to show the dismiss note with the same background
        // color as the form.
        Color(.systemGroupedBackground)
            .ignoresSafeArea()
            .overlay {

                VStack {

                    // If we're in modal (sheet) state and the contents were
                    // edited, display a note that the view can only be
                    // dismissed by tapping the cancel button.
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

                        // Section with topic selection and text editor.
                        topicSection

                        // Section for attachment images.
                        attachmentsSection

                        // Section for device info (model name and OS version).
                        deviceInfoSection

                        // Section for app info (Name, version, build).
                        appInfoSection
                    }
                    #if !os(visionOS)
                    // Allow the user to dismiss the keyboard by swiping.
                    .scrollDismissesKeyboard(.interactively)
                    #endif
                    // Don't allow drag down to dismiss if we're in modal
                    // state and the contents have been edited.
                    .interactiveDismissDisabled(
                        configuration.isModal && state == .edited
                    )
                    .onChange(of: selectedPhotoItems) { selectedPhotoItems in

                        // Selecting a photo as attachment means that the
                        // report has been edited and therefore cannot be
                        // dismissed by dragging down.
                        withAnimation {
                            state = .edited
                        }

                        // Retrieve the UIImages from the selected photo
                        // items and store them.
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

                        // Editing text means that the report has been edited
                        // and therefore cannot be dismissed by dragging down.
                        withAnimation {
                            state = .edited
                        }
                    }
                    .sheet(isPresented: $showMailView) {
                        MailView(
                            data: $email,
                            callback: { result in

                                // Can't dismiss the view if not shown
                                // as a sheet.
                                guard configuration.isModal else {
                                    return
                                }

                                switch result {

                                case .success(let composeResult):
                                    switch composeResult {

                                    case .sent:
                                        // If the email was sent successfully,
                                        // dismiss the feedback manager,
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

// MARK: - Theme Section

extension FeedbackManagerView {

    @ViewBuilder
    var topicSection: some View {
        
        Section(Strings.headerTopic) {

            // Menu picker for the selected topic.
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
                            selectedTopic.name
                        )
                    )
                    .foregroundStyle(.secondary)

                    Spacer()

                    // Button to clear the text editor content.
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
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
                    .frame(minHeight: 100)
                    .focused($isTextFieldFocused)
                    #if !targetEnvironment(macCatalyst) && !os(visionOS)
                    .keyboardDoneButton {
                        isTextFieldFocused = false
                    }
                    #endif
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

                AttachmentView {
                    ForEach(0..<selectedAttachmentImages.count, id: \.self) { idx in

                        Card {
                            Image(uiImage: selectedAttachmentImages[idx])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .overlay(alignment: .bottomTrailing) {
                                    // Button to delete the image.
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
        
        // Create attachments from the selected images.
        var idx = 0
        email.attachments = selectedAttachmentImages.map {

            idx += 1

            return AttachmentData(
                data: $0.jpegData(compressionQuality: 1.0)!,
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

        // If sending mail via MFMailComposeViewController is not possible,
        // at least try to open the standard mail app.
        // Note that the image attachments are not sent with this method.
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
                // If opening the standard mail app also fails, display an error
                // explaining that no emails can be sent from this device.
                showMailErrorAlert = true
            }

            return
        }

        // Update the email's body with the appended device and app info.
        email.body = body

        // Show the MFMailComposeViewController view.
        showMailView = true
    }
}

// MARK: - Data Types

extension FeedbackManagerView {

    enum EditState {

        case vanilla
        case edited
    }
}

#Preview {

    NavigationStack {
        FeedbackManagerView(configuration: .init(recipients: ["email@test.com"]))
    }
}

#Preview {

    NavigationStack {
        FeedbackManagerView(
            configuration: .init(isModal: false, recipients: ["email@test.com"])
        )
    }
}
