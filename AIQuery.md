#  AI Query

26.03.11
- Prompt: Decoding data using "swift" keyword is working, but using "html" is not. They use same API. Find what I'm missing.
    - background: Repo의 description이 nullable인데 optional 처리가 되지 않아 "html"로 검색했을 때 description이 없는 repo에 대해서 json decode가 실패했었음

- Prompt: Add function for open repo.html_url when user tap RepoSearchCell
    - background: 검색결과를 터치했을 때 repo의 html을 오픈하는 기능을 구현

- Prompt: Change a method opening url from using external browser to using WebView.
    - background: 검색결과를 터치했을 때 외부브라우저(safari)로 실행시켜서 이를 내부의 WebView로 띄우게 하기 위해 수정

- Prompt: To reduce user's interaction, show webview using modal in SearchView, not using NavigationLink method.
    - background: NavigationLink를 이용해서 WebView를 띄우는게 UX적으로 불편하다는 생각이 들었고 .sheet를 이용하여 modal 형식으로 띄우게 하기 위해 수정

- Prompt: When scrolling down the search results, modify the page to load additional repositories. This will preserve the existing search results and append the newly loaded repositories to the end of the existing search results.
    - background: pagination 기능 구현


26.03.12
- Prompt: Add a share button in RepoWebView to share URL externally.
    - background: 내부 WebView에서 외부 브라우저로 링크를 공유할 수 있게 수정

- Prompt: Add an auto-complete feature when user type search keyword. Auto-complete keywords panel should appear under the searchField, and the most recent search date should be displayed in mm.dd format next to keyword in the panel. Use recentKeywords to extract auto-complete keyword.
    - background: 검색어 자동완성 기능 추가

- Prompt: Make a button separated from autocompletepanel. Parameter for a button should be autoCompleteSuggestions type.
    - background: 자동완성 panel 코드에 있는 Button의 label 부분을 별도의 cell 파일로 관리하기 위해 분리

- Prompt: It seems like repo search result remains when I start typing new keyword after clear the previous keyword using backspace in keyboard. Find what I'm missing and improve the logic.
    - background: 키보드 백스페이스로 키워드를 삭제할 때 이전에 검색한 repo result가 남아있는 버그 수정
