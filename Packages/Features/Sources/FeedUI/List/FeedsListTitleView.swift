import DesignSystem
import Client
import SwiftUI

public struct FeedsListTitleView: View {
  @Binding var filter: FeedsListFilter
  @Binding var searchText: String
  @Binding var isInSearch: Bool
  var isSearchFocused: FocusState<Bool>.Binding

  public init(
    filter: Binding<FeedsListFilter>,
    searchText: Binding<String>,
    isInSearch: Binding<Bool>,
    isSearchFocused: FocusState<Bool>.Binding
  ) {
    self._filter = filter
    self._searchText = searchText
    self._isInSearch = isInSearch
    self.isSearchFocused = isSearchFocused
  }

  public var body: some View {
    HStack(alignment: .center) {
      Menu {
        ForEach(FeedsListFilter.allCases) { filter in
          Button(action: {
            self.filter = filter
          }) {
            Label(filter.rawValue, systemImage: filter.icon)
          }
        }
      } label: {
        HStack {
          VStack(alignment: .leading, spacing: 2) {
            Text("Feeds")
              .headerTitleShadow()
              .font(.title)
              .fontWeight(.bold)
            Text(filter.rawValue)
              .font(.subheadline)
              .foregroundStyle(.secondary)
          }
          VStack(spacing: 6) {
            Image(systemName: "chevron.up")
            Image(systemName: "chevron.down")
          }
          .imageScale(.large)
          .offset(y: 2)
        }
      }
      .buttonStyle(.plain)
      .offset(x: isInSearch ? -200 : 0)
      .opacity(isInSearch ? 0 : 1)

      Spacer()

      FeedsListSearchField(
        searchText: $searchText,
        isInSearch: $isInSearch,
        isSearchFocused: isSearchFocused
      )
      .padding(.leading, isInSearch ? -120 : 0)
      .contentShape(Rectangle())
      .onTapGesture {
        withAnimation(.bouncy) {
          isInSearch.toggle()
          isSearchFocused.wrappedValue = true
        }
      }
      .transition(.slide)
    }
    .animation(.bouncy, value: isInSearch)
  }
}
