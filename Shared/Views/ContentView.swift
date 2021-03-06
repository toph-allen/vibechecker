//
//  ContentView.swift
//  Shared
//
//  Created by Toph Allen on 6/25/20.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.taskContext) var taskContext

    @FetchRequest(entity: Container.entity(), sortDescriptors: [], predicate: NSPredicate(format: "parent == nil")) var rootContainers: FetchedResults<Container>

//    @State private var selectedContainer: Container? = nil
    @State private var selectedTrack: Track? = nil
    @State private var presentingImportView = false

    
    var body: some View {
        Group {
            if presentingImportView == false {
                NavigationView {
                    Sidebar(rootContainers: rootContainers)
                    
//                    switch selectedContainer {
//                    case let vibe as Vibe:
//                        VibeDetail(vibe: vibe)
//                    case let playlist as Playlist:
//                        PlaylistDetail(playlist: playlist)
//                    default:
//                        Text("No Vibe or Playlist Selected")
//                            .font(.title)
//                            .fontWeight(.light)
//                            .foregroundColor(.tertiaryLabel)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    }
                }
            } else {
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem {
                Button(action: { presentingImportView = true }, label: {
                    Label("Import Tracks", systemImage: "square.and.arrow.down")
                }).sheet(isPresented: $presentingImportView) {
                    ImportView(importer: ITunesImporter(for: taskContext))
                    .environment(\.managedObjectContext, self.moc)
                    .environment(\.taskContext, self.taskContext)
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


