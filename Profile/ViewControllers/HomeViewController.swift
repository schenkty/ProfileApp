//
//  HomeViewController.swift
//  Profile
//
//  Created by Ty Schenk on 11/7/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import Speech

class HomeViewController: UIViewController {
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var weatherButton: UIButton!
    @IBOutlet var micButton: UIButton!
    @IBOutlet var micText: UITextView!
    @IBOutlet var tableView: UITableView!
    
    // MARK: Vars
    // Weather
    let client = WeatherAPIClient()
    var locationManager: CLLocationManager!
    
    // Speech
    var status = SpeechStatus.ready {
        didSet {
            self.setUI(status: status)
        }
    }
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Weather
        updateWeather()
        
        // Nav Bar Setup
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.topItem?.title = "Ty Schenk"
        
        // Speech
        switch SFSpeechRecognizer.authorizationStatus() {
        case .notDetermined:
            askSpeechPermission()
        case .authorized:
            self.status = .ready
        case .denied, .restricted:
            self.status = .unavailable
        }
    }
    
    // MARK: Weather
    
    @IBAction func updateWeather() {
        determineMyCurrentLocation()
        
        // MARK: Adjust cords here. pls update with user's loc and loc name
        guard let latitude = locationManager.location?.coordinate.latitude, let longitude = locationManager.location?.coordinate.longitude else { return }
        
        let cordinate = Cordinate(latitude: latitude, longitude: longitude)
        
        client.getCurrentWeather(at: cordinate) { [unowned self] currentWeather, error in
            if let currentWeather = currentWeather {
                let viewModel = WeatherViewModel(model: currentWeather)
                self.displayWeather(using: viewModel)
            }
        }
    }
    
    func displayWeather(using viewModel: WeatherViewModel) {
        weatherButton.setTitle(viewModel.temperature, for: .normal)
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
        showAlert(title: "Can not find user location")
    }
    
    // MARK: Speech
    
    // Ask the user for permission
    func askSpeechPermission() {
        SFSpeechRecognizer.requestAuthorization { status in
            OperationQueue.main.addOperation {
                switch status {
                case .authorized:
                    self.status = .ready
                default:
                    self.status = .unavailable
                }
            }
        }
    }
    
    // Start Recording the user's voice
    func startRecording() {
        // Setup audio engine and speech recognizer
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        // Prepare and start recording
        audioEngine.prepare()
        do {
            try audioEngine.start()
            self.status = .recognizing
        } catch {
            return print(error)
        }
        
        // Analyze the speech
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                self.micText.text = result.bestTranscription.formattedString
                
                guard let command = CommandDataSource.searchCommands(words: result.bestTranscription.formattedString) else { return }
                self.micText.text = command.title
                
                print("Command Found: \(command.title). Loading: \(command.location)")
                
                switch command.act {
                case .Url:
                    self.loadWebView(url: command.location)
                default:
                    print("Comamnd not found")
                }
            } else if let error = error {
                print(error)
            }
        })
    }
    
    // Cancel Recording the user's voice
    func cancelRecording() {
        audioEngine.stop()
        let node = audioEngine.inputNode
        node.removeTap(onBus: 0)
        recognitionTask?.cancel()
        self.micText.text = "Tap the Button to ask a question 💬"
    }
    
    @IBAction func micButtonAction() {
        switch status {
        case .ready:
            startRecording()
            status = .recognizing
        case .recognizing:
            cancelRecording()
            status = .ready
        default:
            break
        }
    }
    
}
