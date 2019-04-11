Trait {
	#name : #TAPWiki,
	#category : #'ActivePapers-Wiki'
}

{ #category : #accessing }
TAPWiki classSide >> createOrRetrieveWikiPageNamed: aSymbol [
	|  pageName |
	pageName := self normalizeWikiPageName: aSymbol. 
	^ (self wikiPageNamed: name)
		ifNil: [ ^ (APWikiPage wiki: self name: pageName text: self initialWikiPageContents) store ]

]

{ #category : #inspecting }
TAPWiki classSide >> gtDocumentFor: aView [
	"<gtView> is inherited from the overriden implementation in Class"
	| aDocument |
	aDocument := GtDocument new
							strategy: (APWikiPageStorageStrategy new container: self; name: #Main);
							read.
	^ (aDocument gtTextFor: aView)
		title: 'Main page';
		priority: -1;
		action: [ :anAction | 
			aDocument gtSaveActionFor: anAction ];
		action: [ :anAction | 
			aDocument gtShowMarkupActionFor: anAction ]
]

{ #category : #inspecting }
TAPWiki classSide >> gtPagesFor: aView [
	<gtView>
	^ aView list
		title: 'Pages' translated;
		priority: 0;
		items: [ self wikiPageNames collect: [ :pn | self wikiPageNamed: pn ] ];
		itemFormat: [ :page | page name ]
]

{ #category : #testing }
TAPWiki classSide >> hasWikiPageNamed: aSymbol [
	^ aSymbol = #Main
		or: [ self respondsTo: (self methodSelectorForWikiPageNamed: aSymbol) ]
]

{ #category : #accessing }
TAPWiki classSide >> initialWikiPageContents [
	^ '!New page'
]

{ #category : #accessing }
TAPWiki classSide >> methodSelectorForWikiPageNamed: aSymbol [
	^ ('wikiPage', (self normalizeWikiPageName: aSymbol)) asSymbol
]

{ #category : #accessing }
TAPWiki classSide >> normalizeWikiPageName: aSymbol [
	^ aSymbol capitalized
]

{ #category : #deleting }
TAPWiki classSide >> removeWikiPageNamed: aSymbol [
	self class removeSelector: (self methodSelectorForWikiPageNamed: aSymbol)
]

{ #category : #accessing }
TAPWiki classSide >> store: aString inWikiPageNamed: aSymbol [
	| pageName code |

	pageName := self normalizeWikiPageName: aSymbol. 

	pageName = #Main
		ifTrue: [ self comment: aString. ^ self ].

	code := String streamContents: [ :s |
		s nextPutAll: (self methodSelectorForWikiPageNamed: aSymbol).
		s crtab; nextPutAll: '"This method was automatically generated."'.
		s crtab; nextPutAll: '<wikiPage: '; nextPutAll: pageName storeString; nextPutAll: '>'.
		s crtab; nextPutAll: '^APWikiPage'.
		s crtab: 2; nextPutAll: 'wiki: self'.
		s crtab: 2; nextPutAll: 'name: '; nextPutAll: pageName storeString.
		s crtab: 2; nextPutAll: 'text: '.
		s cr; nextPutAll: aString storeString.
	].

	self class compile: code classified: 'wikiPages'.
]

{ #category : #accessing }
TAPWiki classSide >> wikiEvaluationReceiverForPage: aSymbol [
	"The evaluationReceiver for scripts embedded into Wiki pages.
	By default it is the class, for all pages, but classes can override this method."
	^ self
]

{ #category : #accessing }
TAPWiki classSide >> wikiPageNamed: aSymbol [
	|  pageName |
	pageName := self normalizeWikiPageName: aSymbol. 
	pageName = #Main
		ifTrue: [ ^ APWikiPage wiki: self name: pageName text: self comment ].
	^ [ self perform: (self methodSelectorForWikiPageNamed: pageName) ]
		on: MessageNotUnderstood do: [ nil ]
		
]

{ #category : #accessing }
TAPWiki classSide >> wikiPageNames [
	| pageNames |
	pageNames := ((Pragma allNamed: #wikiPage: in: self class)
						collect: [ :p | p argumentAt: 1 ])
					 	asOrderedCollection.
	pageNames sort.
	pageNames addFirst: #Main.
	^ pageNames asArray
]
