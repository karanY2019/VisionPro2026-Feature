//
//  ChangeWallColor.swift
//  Floor
//
//  Created by Scuuu on 2025/5/6.
//

import SwiftUI
import Speech
import AVFoundation

struct ChangeWallColorView: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) private var openWindow
    @Environment(AppModel.self) private var appModel
    @State private var searchText: String = ""
    
    @State private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var audioEngine = AVAudioEngine()
    
    @State private var colorCardData: ColorCardData = [:]
    @State private var selectedColors: [PaintColor] = []
    
    @State private var colorSnapColors: [PaintColor] = []
    
    @State private var isRecognizing = false
    
    var filteredColors: [PaintColor] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return selectedColors }

        return selectedColors.filter {
            $0.colorName.lowercased().contains(query) ||
            $0.colorID.lowercased().contains(query)
        }
    }
    
    var body: some View {
        @Bindable var model = appModel
        
        VStack {
            Spacer().frame(height: 29)
            
            Text("Wall Paint")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
            
            ZStack(alignment: .center, spacing: 0) {
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.black.opacity(0.15))
                    .frame(height: 44)
                
                HStack(spacing: 0) {
                        Button(action: {
                            appModel.currentColorCard = "Emerald Designer"
                            if appModel.currentWallStyle == "All" {
                                    selectedColors = colorCardData.values.flatMap { $0 }
                                } else {
                                    selectedColors = colorCardData[appModel.currentWallStyle] ?? []
                                }
//                                appModel.currentSelectedColor = selectedColors.first
                        }) {
                            Text("Emerald Designer")
                                .frame(width: 615, height: 36)
                                .foregroundColor(.white)
                                .cornerRadius(18)
                                .background(appModel.currentColorCard == "Emerald Designer" ? Color.white.opacity(0.06) : Color.clear)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(18)
                        .background(Color.clear)

                        
                        Button(action: {
                            appModel.currentColorCard = "ColorSnap®"
                            selectedColors = colorSnapColors
                            appModel.currentWallStyle = "All"
//                            appModel.currentSelectedColor = selectedColors.first
                        }) {
                            Text("ColorSnap®")
                                .frame(width: 615, height: 36)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .background(appModel.currentColorCard == "ColorSnap®" ? Color.white.opacity(0.06) : Color.clear)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(18)
                        .background(Color.clear)
                    }
            }
            .frame(width: 1240)
            
            Spacer().frame(height: 18)
            
            VStack(spacing: 0) {
                HStack {
                    if appModel.currentColorCard == "Emerald Designer" {
                        Menu {
                            Button {
                                appModel.currentWallStyle = "All"
                                selectedColors = colorCardData.values.flatMap { $0 }
                            } label: {
                                HStack {
                                    Text("All")
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(appModel.currentWallStyle == "All" ? Color.black.opacity(0.5) : Color.clear)
                                }
                                .background(appModel.currentWallStyle == "All" ? Color.black.opacity(0.5) : Color.clear)
                                .cornerRadius(8)
                            }
                            
                            Divider()
                                .frame(width: 210)
                                .background(Color.gray.opacity(0.5))
                            
                            ForEach(Array(colorCardData.keys.sorted()), id: \.self) { style in
                                Button {
                                    appModel.currentWallStyle = style
                                    selectedColors = colorCardData[style] ?? []
                                } label: {
                                    HStack {
                                        Text(style)
                                            .foregroundColor(.white)
                                            .padding(8)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(appModel.currentWallStyle == style ? Color.black.opacity(0.5) : Color.clear)
                                    }
                                    .background(appModel.currentWallStyle == style ? Color.black.opacity(0.5) : Color.clear)
                                    .cornerRadius(8)
                                }
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Text(appModel.currentWallStyle)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)

                                Image(systemName: "chevron.down")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 22)
                            .fill(Color.white.opacity(0.15))
                            .frame(height: 44)
                        
                        HStack {
                            
                            Image("Mic_Button")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 28, height: 28)
                                .clipShape(Circle())
                                .background(Color.clear)
                                .cornerRadius(14)
                                .padding(8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    print("Mic button pressed")
                                    #if targetEnvironment(simulator)
                                    print("Speech recognition is not supported in the simulator.")
                                    #else
                                    startSpeechRecognition()
                                    #endif
                                }
                                .onTapGesture {
                                    print("Mic button pressed")
                                    #if targetEnvironment(simulator)
                                    print("Speech recognition is not supported in the simulator.")
                                    #else
                                    if isRecognizing {
                                        stopSpeechRecognition()
                                    } else {
                                        startSpeechRecognition()
                                    }
                                    isRecognizing.toggle()
                                    #endif
                                }
                            
                            TextField("Search", text: $searchText)
                                .foregroundColor(.white)
                                .textFieldStyle(PlainTextFieldStyle())
                                .frame(width: 167)
                        }
                        .padding(.trailing, 12)
                    }
                    .frame(width: 219)
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        if filteredColors.isEmpty {
                            Text("No match color")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .medium))
                                .padding(.top, 180)
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 8), spacing: 14) {
                                ForEach(filteredColors) { color in
                                    WallColorButtonV2(color: color) {
                                        appModel.currentSelectedColor = color
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            print("Current Product:", appModel.currentProduct?.title ?? "No product selected")
            print("Current Items:", appModel.currentItems.count)
            
            if appModel.currentProduct == nil, let firstProduct = appModel.productList.first {
                appModel.updateCurrentProduct(firstProduct.type)
            }
            
            if let loaded = loadEmeraldDesignerColors() {
                colorCardData = loaded
            }

            colorSnapColors = loadColorSnapColors()

            switch appModel.currentColorCard {
            case "Emerald Designer":
                selectedColors = appModel.currentWallStyle == "All"
                    ? colorCardData.values.flatMap { $0 }
                    : colorCardData[appModel.currentWallStyle] ?? []

            case "ColorSnap®":
                selectedColors = colorSnapColors

            default:
                break
            }

            if appModel.currentSelectedColor == nil {
                appModel.currentSelectedColor = selectedColors.first
            }
        }
    }
    
    func startSpeechRecognition() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            guard authStatus == .authorized else {
                print("Speech recognition not authorized")
                return
            }

            DispatchQueue.main.async {
                self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                
                let inputNode = audioEngine.inputNode

                guard let recognitionRequest = recognitionRequest else {
                    print("Unable to create recognition request")
                    return
                }

                recognitionRequest.shouldReportPartialResults = true

                self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                    if let result = result {
                        self.searchText = result.bestTranscription.formattedString
                    }

                    if error != nil || (result?.isFinal ?? false) {
                        self.audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        self.recognitionRequest = nil
                        self.recognitionTask = nil
                    }
                }

                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
                    self.recognitionRequest?.append(buffer)
                }

                do {
                    self.audioEngine.prepare()
                    try self.audioEngine.start()
                    print("🎤 Listening...")
                } catch {
                    print("Audio Engine failed to start: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func stopSpeechRecognition() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        recognitionTask = nil
        print("🛑 Speech recognition stopped")
    }
}


struct WallColorButton: View {
    let item: PItemDetail
    var onSelect: () -> Void
    @Environment(AppModel.self) private var appModel

    var isSelected: Bool {
        return appModel.currentDetailItem?.id == item.id
    }
    
    var body: some View {
        VStack {
            if let uiImage = UIImage(named: item.thumbnailUrl) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 75)
                    .clipShape(Circle())
            } else {
                Text("Image Not Found")
                    .frame(width: 100, height: 100)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            
            Text(item.name)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: 100)
            
            Text("SW9501")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: 100)
        }
        .padding(8)
        .background(isSelected ? Color.black.opacity(0.5) : Color.clear)
        .cornerRadius(12)
        .onTapGesture {
            print("Selected item: \(item.name)")
            onSelect()
        }
    }
}

struct WallColorButtonV2: View {
    let color: PaintColor
    var onSelect: () -> Void
    @Environment(AppModel.self) private var appModel

    var isSelected: Bool {
        appModel.currentSelectedColor?.id == color.id
    }

    var body: some View {
        VStack {
            Circle()
                .fill(Color(hex: color.hex))
                .frame(width: 100, height: 75)

            Text(color.colorName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: 100)

            Text(color.colorID)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: 100)
        }
        .padding(8)
        .background(isSelected ? Color.black.opacity(0.5) : Color.clear)
        .cornerRadius(12)
        .onTapGesture {
            onSelect()
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
