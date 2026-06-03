//
//  ClientsViewModelSupprimerTests.swift
//  RelayanceTests — Livrable 2 : Tests d'intégration — Suppression de client
//
//  Created by Jaouad on 26/05/2026.
//

import XCTest
@testable import Relayance

final class ClientsViewModelSupprimerTests: XCTestCase {

    var viewModel: ClientsViewModel!
    var clientTest: Client!

    override func setUp() {
        super.setUp()
        clientTest = Client(nom: "Jean Dupont", email: "jean@test.com", dateCreationString: "2023-01-01")
        viewModel = ClientsViewModel(clients: [clientTest])
    }

    override func tearDown() {
        viewModel = nil
        clientTest = nil
        super.tearDown()
    }

    func testSupprimerClient_clientExistant_estRetireDeLaListe() {
        // Given
        XCTAssertEqual(viewModel.clients.count, 1)

        // When
        viewModel.supprimerClient(clientTest)

        // Then
        XCTAssertEqual(viewModel.clients.count, 0)
    }

    func testSupprimerClient_clientExistant_nAppartientPlusALaListe() {
        // When
        viewModel.supprimerClient(clientTest)

        // Then
        XCTAssertFalse(clientTest.clientExiste(clientsList: viewModel.clients))
    }

    func testSupprimerClient_avecPlusieursClients_autresClientsSontConserves() {
        // Given
        let autreClient = Client(nom: "Marie", email: "marie@test.com", dateCreationString: "2023-06-01")
        viewModel = ClientsViewModel(clients: [clientTest, autreClient])

        // When
        viewModel.supprimerClient(clientTest)

        // Then
        XCTAssertEqual(viewModel.clients.count, 1)
        XCTAssertTrue(autreClient.clientExiste(clientsList: viewModel.clients))
    }

    func testSupprimerClient_clientInexistant_listeResteInchangee() {
        // Given
        let clientInexistant = Client(nom: "Inconnu", email: "inconnu@test.com", dateCreationString: "2023-01-01")

        // When
        viewModel.supprimerClient(clientInexistant)

        // Then
        XCTAssertEqual(viewModel.clients.count, 1)
    }
}
