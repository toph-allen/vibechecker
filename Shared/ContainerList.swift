//
//  ContainerList.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI

struct ContainerList: View {
    var rootContainers: FetchedResults<Container>
    @Binding var selectedContainer: Container?
    
    var body: some View {

            List(selection: $selectedContainer) {
                Section(header: Text("Vibes")) {
                    OutlineGroup(rootContainers.filter({$0.inVibeTree == true}).first?.childArray ?? [], children: \.childArray) { vibe in
                        ContainerRow(vibe).tag(vibe)
                    }
                }
                Section(header: Text("Playlists")) {
                    OutlineGroup(rootContainers.filter({$0.inVibeTree == false}), children: \.childArray) { vibe in
                        ContainerRow(vibe).tag(vibe)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle(selectedContainer != nil ? Text(selectedContainer!.name ?? "") : Text("VibeChecker"))
    }
}


//struct ContainerList_Previews: PreviewProvider {
//    static var previews: some View {
//        ContainerList()
//    }
//}