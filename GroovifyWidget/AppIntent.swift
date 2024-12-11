//
//  AppIntent.swift
//  Groovify
//
//  Created by Iman on 2024-12-10.
//


import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Groovify", default: "😃")
    var favoriteEmoji: String
}
