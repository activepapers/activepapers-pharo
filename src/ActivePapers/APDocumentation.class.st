"
!ActivePapers Pharo edition

*ActivePapers>https://www.activepapers.org/* is a research and development project to improve scientific communication involving computational results. This Pharo edition of ActivePapers explores the user interface and documentation aspects.

An ActivePaper is a package of code, data, and narratives which together convey the results of a computer-aided research study as clearly and precisely as possible.
The main functionality provided by this package is:
 - A ${wikiPage:name=Wiki}$ that can be added to any Pharo class to serve as its documentation.
 - The ${class:name=APActivePaper}$ class for computational documents.

For a small but complete use case, see ${activePaper:name=InfluenzaLikeIllnessIncidenceInFrance}$. 

"
Class {
	#name : #APDocumentation,
	#superclass : #Object,
	#traits : 'TAPWiki',
	#classTraits : 'TAPWiki classTrait',
	#category : #'ActivePapers-Documentation'
}

{ #category : #wikiPages }
APDocumentation class >> wikiPageWiki [
	"This method was automatically generated."
	<wikiPage: #Wiki>
	^APWikiPage
		wiki: self
		name: #Wiki
		text: 
'!Wikis

To add a documentation wiki to a Pharo class, it is sufficient to use the trait  ${class:name=TAPWiki|show=#gtDocumentFor:|expanded=}$. 

For an example of a wikified class, see ${class:name=APDocumentation}$.

See ${wikiPage:name=WikiImplementation}$ for an explanation of how the wiki is implemented. This is not required reading for using the wiki, but potentially of interest to anyone wishing to extend GToolkit.
'
]

{ #category : #wikiPages }
APDocumentation class >> wikiPageWikiImplementation [
	"This method was automatically generated."
	<wikiPage: #WikiImplementation>
	^APWikiPage
		wiki: self
		name: #WikiImplementation
		text: 
'!Wiki implementation

!!Executive summary

- The trait ${class:name=TAPWiki}$ provides methods that generate the views for the main page (${method:name=TAPWiki class>>#gtMainPageFor:}$) and for the page list (${method:name=TAPWiki class>>#gtPagesFor:}$). Further methods serve to create, retrieve, and remove wiki pages. Display and editing of the Pillar code is handled by ${class:name=GtDocument}$.

- The class ${class:name=APWikiPage}$ serves for displaying and editing pages other than the main page.

- The class ${class:name=APWikiLinkAnnotation}$ represents Pillar annotations with the tag ==wikiPage==. Its instances are created by the Pillar parser. The class defines how wiki links are rendered and how they react to user interaction (mouse clicks). Note that Pillar annotations are defined globally in a Pharo image. Wiki links can therefore be used in any Pillar document and will always create instances of this class. It therefore checks if the document it is embedded in actually is a wiki before it activates links.

- The class ${class:name=APWikiPageStorageStrategy}$ ensures the communication between the preceding classes and GToolkit. A new ${class:name=GtDocument}$ instance is given a ${class:name=GtStorageStrategy}$ instance so that it can read and store its plain text representation. An ${class:name=APWikiLinkAnnotation}$ accesses the wiki class via the ${class:name=GtDocument}$''s storage strategy.

!!The full story

When you inspect a wikified class, the GToolkit inspector first searches all its methods (including inherited methods) for the presence of the ==<gtView>== pragma. Each of these methods is called to define one view. For a wikified class, these include ${method:name=TAPWiki class>>#gtMainPageFor:}$ and ${method:name=TAPWiki class>>#gtPagesFor:}$. The latter one is rather simple, so let''s concentrate on the first one.

The method ${method:name=TAPWiki class>>#gtMainPageFor:}$ starts by creating an instance of ${class:name=GtDocument}$ to which it feeds an instance of ${class:name=APWikiPageStorageStrategy}$ parametrized for the wiki''s main page. That instance is what all players in the wiki game share to communicate. It is accessible from the document via the method ${method:name=GtDocument>>#storage}$.

The GtDocument starts by retrieving the Pillar text for the wiki page via ${method:name=APWikiPageStorageStrategy>>#read:}$. It parses this text using ${class:name=PRPillarParser}$, yielding an instance of ${class:name=PRDocument}$ that represents the parse tree. This instance has access to the GtDocument via ${method:PRDocumentItem>>#gtDocument}$. Whenever the parser sees an annotation (Pillar''s mechanism for syntax extensions), it takes its tag and looks for a class that claims responsibility for handling that tag, via a class method called ==tag==. For ==wikiPage==, this is ${method:name=APWikiLinkAnnotation class>>#tag}$. That''s how an instance of ${class:name=APWikiLinkAnnotation}$ ends up in the parse tree.

The document is then rendered by traversing the parse tree. For ==wikiPage== annotations, this involves calling one of ${method:name=APWikiLinkAnnotation>>#styleTextWithMarkup:}$ and ${method:name=APWikiLinkAnnotation>>#styleTextWithoutMarkup:}$, depending on the rendering mode and the position of the cursor. In either case, the link gets shown in color (blue for existing pages, red for non-existing ones). It also gets user interaction events attached to it: a mouse cursor hovering over it adds an underline, and a click activates the link, via ${method:name=APWikiLinkAnnotation>>#browseReferenceFrom:}$. This requires access to the wikified class, which is mediated by the GtDocument and the APWikiPageStorageStrategy.

There''s one detail that deserves being mentioned. The registry for annotation handlers is system-wide. You can use ==wikiPage== tags in any Pillar document, not just in wiki pages. The annotation therefore checks if it is embedded into a wiki page (via ${method:name=APWikiLinkAnnotation>>#isInWiki}$) before trying to follow wiki links.

For pages other than the main page, an instance of ${class:name=APWikiPage}$ is created, which is processed in much the same way as tha main page. The entry point is the view defined in ${method:APWikiPage>>#gtDocumentFor:}$.

Storage and retrieval of pages is handled by three methods of class trait ${class:name=TAPWiki}$:
- ${method:name=TAPWiki class>>#wikiPageNamed:}$ retrieves an existing page
- ${method:name=TAPWiki class>>#createOrRetrieveWikiPageNamed:}$ retrieves a page if it exists, or else creates a new one with the initial content defined in ${method:name=TAPWiki class>>#initialWikiPageContents}$
- ${method:name=TAPWiki class>>#store:inWikiPageNamed:}$ stores new text in an existing page, or creates a new page with the given text
- ${method:name=TAPWiki class>>#removeWikiPageNamed:}$ removes a page. The main page cannot be deleted.

Wiki pages are stored in class-side methods whose name is the capitalized page name prefixed by ==wikiPage==. This choice is motivated by the ease of keeping pages under version control along with the code they document. At the moment, Iceberg (Pharo''s git interface) handles only code, so wiki pages have to become code as well. The one exception is the main page, which is stored in the class comment.

'
]
