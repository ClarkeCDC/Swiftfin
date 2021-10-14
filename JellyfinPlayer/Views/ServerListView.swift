//
 /* 
  * SwiftFin is subject to the terms of the Mozilla Public
  * License, v2.0. If a copy of the MPL was not distributed with this
  * file, you can obtain one at https://mozilla.org/MPL/2.0/.
  *
  * Copyright 2021 Aiden Vigue & Jellyfin Contributors
  */

import CoreStore
import SwiftUI

struct ServerListView: View {
    
    @EnvironmentObject var serverListRouter: ServerListCoordinator.Router
    @ObservedObject var viewModel: ServerListViewModel
    
    @ViewBuilder
    private var listView: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.servers, id: \.id) { server in
                    Button {
                        serverListRouter.route(to: \.userList, server)
                    } label: {
                        ZStack(alignment: Alignment.leading) {
                            Rectangle()
                                .foregroundColor(Color(UIColor.secondarySystemFill))
                                .frame(height: 100)
                                .cornerRadius(10)
                            
                            HStack {
                                Image(systemName: "server.rack")
                                    .font(.system(size: 36))
                                    .foregroundColor(.primary)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(server.name)
                                        .font(.title2)
                                        .foregroundColor(.primary)
                                    
                                    Text(server.uri)
                                        .font(.footnote)
                                        .disabled(true)
                                        .foregroundColor(.secondary)
                                    
                                    Text(viewModel.userTextFor(server: server))
                                        .font(.footnote)
                                        .foregroundColor(.primary)
                                }
                            }.padding([.leading])
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var noServerView: some View {
        VStack {
            Text("Connect to a Jellyfin server to get started.")
                .frame(minWidth: 50, maxWidth: 240)
                .multilineTextAlignment(.center)
            
            Button {
                serverListRouter.route(to: \.connectToServer)
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.jellyfinPurple)
                        .frame(maxWidth: 500, maxHeight: 50)
                        .frame(height: 50)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 30)
                        .padding([.top, .bottom], 20)
                    
                    Text("Connect")
                        .foregroundColor(Color.white)
                        .bold()
                }
            }
        }
    }
    
    @ViewBuilder
    private var innerBody: some View {
        if viewModel.servers.isEmpty {
            noServerView
                .offset(y: -50)
        } else {
            listView
        }
    }
    
    @ViewBuilder
    private var toolbarContent: some View {
        if viewModel.servers.isEmpty {
            EmptyView()
        } else {
            HStack {
                Button {
                    SwiftfinStore.dataStack.perform(asynchronous: { transaction in
                        try! transaction.deleteAll(From<SwiftfinStore.Models.StoredServer>())
                        try! transaction.deleteAll(From<SwiftfinStore.Models.StoredUser>())
                        try! transaction.deleteAll(From<SwiftfinStore.Models.StoredAccessToken>())
                    }) { _ in
                        SwiftfinStore.Defaults.suite[.lastServerUserID] = nil
                        viewModel.fetchServers()
                    }
                } label: {
                    Text("Purge")
                }
                
                Button {
                    serverListRouter.route(to: \.connectToServer)
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
    
    var body: some View {
        innerBody
        .navigationTitle("Servers")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                toolbarContent
            }
        }
        .onAppear {
            viewModel.fetchServers()
        }
    }
}
