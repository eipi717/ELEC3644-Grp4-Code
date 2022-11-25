//
//  VoiceRec.swift
//  Workout
//
//  Created by Nicholas Ho on 24/11/2022.
//

import SwiftUI
import Speech

struct VoiceRec: View {
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    @State var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State var recognitionTask: SFSpeechRecognitionTask?
    
    @Binding var message: String
    @State var buttonStatus = true
    var body: some View {
        VStack {
            TextEditor(text: $message)
                .frame(width: 350, height: 400)
            
            Button(buttonStatus ? "Start recording" : "Stop recording", action: {
                buttonStatus.toggle()
                if buttonStatus {
                    stopRecording()
                } else {
                    startRecording()
                }
            })
            .padding()
            .background(buttonStatus ? Color.green : Color.red)
        }
    }
    
    
    func stopRecording() {
        audioEngine.stop()
        recognitionTask?.cancel()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
    }
    
    func startRecording() {
        message = ""
        let node = audioEngine.inputNode
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest?.shouldReportPartialResults = true
        
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        guard let recognizeMe = SFSpeechRecognizer() else {
            return
        }
        if !recognizeMe.isAvailable {
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest ?? SFSpeechAudioBufferRecognitionRequest.init(), resultHandler: {result, error in
            if let result = result {
                let transcribedString = result.bestTranscription.formattedString
                message = transcribedString
            } else if let error = error {
                print(error)
            }
        })
    }
}

