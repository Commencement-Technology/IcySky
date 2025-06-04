import AppRouter
import Auth
import AuthUI
import ComposerUI
import Destinations
import MediaUI
import Network
import SwiftUI
import User

public struct SheetDestinations: ViewModifier {
  @Binding var router: AppRouter
  let auth: Auth
  let client: BSkyClient?
  let currentUser: CurrentUser?

  public func body(content: Content) -> some View {
    content
      .sheet(item: $router.presentedSheet) { presentedSheet in
        switch presentedSheet {
        case .auth:
          AuthView()
            .environment(auth)
        case let .fullScreenMedia(images, preloadedImage, namespace):
          FullScreenMediaView(
            images: images,
            preloadedImage: preloadedImage,
            namespace: namespace
          )
        case .composer:
          if let client, let currentUser {
            ComposerView()
              .environment(client)
              .environment(currentUser)
          }
        }
      }
  }
}

extension View {
  public func withSheetDestinations(
    router: Binding<AppRouter>,
    auth: Auth,
    client: BSkyClient? = nil,
    currentUser: CurrentUser? = nil
  ) -> some View {
    modifier(
      SheetDestinations(
        router: router,
        auth: auth,
        client: client,
        currentUser: currentUser
      ))
  }
}
