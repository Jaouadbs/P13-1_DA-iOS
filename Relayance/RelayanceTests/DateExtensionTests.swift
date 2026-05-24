//
//  DateExtensionTests.swift
//  RelayanceTests
//
//  Created by Jaouad on 22/05/2026.
// RelayanceTests — Livrable 1 : Tests unitaires

import XCTest
@testable import Relayance

final class DateExtensionTests: XCTestCase {

    // MARK: - dateFromString

    func testDateFromString_avecFormatYYYYMMDD_retourneDate() {
        // Given
        let isoString = "2023-02-20"

        // When
        let date = Date.dateFromString(isoString)

        // Then
        XCTAssertNotNil(date)
    }

    func testDateFromString_avecStringInvalide_retourneNil() {
        // Given
        let invalide = "pas-une-date"

        // When
        let date = Date.dateFromString(invalide)

        // Then
        XCTAssertNil(date)
    }

    // MARK: - stringFromDate

    func testStringFromDate_retourneStringAuFormatJJMMAAAA() {
        // Given
        let date = Date.dateFromString("2023-02-20")!

        // When
        let string = Date.stringFromDate(date)

        // Then
        XCTAssertEqual(string, "20-02-2023")
    }

    func testStringFromDate_avecDateActuelle_retourneStringNonNil() {
        // Given
        let date = Date.now

        // When
        let string = Date.stringFromDate(date)

        // Then
        XCTAssertNotNil(string)
    }

    // MARK: - getDay

    func testGetDay_retourneLeJourCorrect() {
        // Given
        let date = Date.dateFromString("2023-02-20")!

        // When / Then
        XCTAssertEqual(date.getDay(), 20)
    }

    func testGetDay_autreJourRetourneValeurCorrecte() {
        // Given
        let date = Date.dateFromString("2023-06-15")!

        // When / Then
        XCTAssertEqual(date.getDay(), 15)
    }

    // MARK: - getMonth

    func testGetMonth_retourneLeMoisCorrect() {
        // Given
        let date = Date.dateFromString("2023-02-20")!

        // When / Then
        XCTAssertEqual(date.getMonth(), 2)
    }

    func testGetMonth_autreMoisRetourneValeurCorrecte() {
        // Given
        let date = Date.dateFromString("2023-12-01")!

        // When / Then
        XCTAssertEqual(date.getMonth(), 12)
    }

    // MARK: - getYear

    func testGetYear_retourneLAnneeCorrecte() {
        // Given
        let date = Date.dateFromString("2023-02-20")!

        // When / Then
        XCTAssertEqual(date.getYear(), 2023)
    }

    func testGetYear_autreAnneeRetourneValeurCorrecte() {
        // Given
        let date = Date.dateFromString("2024-01-01")!

        // When / Then
        XCTAssertEqual(date.getYear(), 2024)
    }
}
