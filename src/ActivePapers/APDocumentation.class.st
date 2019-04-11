"
!ActivePapers Pharo edition

*ActivePapers>https://www.activepapers.org/* is a research and development project to improve scientific communication involving computational results. This Pharo edition of ActivePapers explores the user interface and documentation aspects.

An ActivePaper is a package of code, data, and narratives which together convey the results of a computer-aided research study as clearly and precisely as possible.

This software is work in progress. For now, the only implemented functionality is a ${wikiPage:name=Wiki}$ that can be added to any Pharo class to serve as its documentation.

"
Class {
	#name : #APDocumentation,
	#superclass : #Object,
	#traits : 'TAPWiki',
	#classTraits : 'TAPWiki classTrait',
	#category : #ActivePapers
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

- The trait ${class:name=TAPWiki}$ provides methods that generate the views for the main page (${method:name=TAPWiki class>>#gtMainPageFor:}$) and for the page list (${method:name=TAPWiki class>>#gtPagesFor:}$). Further methods serve to create, retrieve, and remove wiki pages. Display and editing of the Pillar code is handled by ${class:name=GtDocument}$.

- The class ${class:name=APWikiPage}$ serves for displaying and editing pages other than the main page.

- The class ${class:name=APWikiLinkAnnotation}$ represents Pillar annotations with the tag ==wikiPage==. Its instances are created by the Pillar parser. The class defines how wiki links are rendered and how they react to user interaction (mouse clicks). Note that Pillar annotations are defined globally in a Pharo image. Wiki links can therefore be used in any Pillar document and will always create instances of this class. It therefore checks if the document it is embedded in actually is a wiki before it activates links.

- The class ${class:name=APWikiPageStorageStrategy}$ ensures the communication between the preceding classes and GToolkit. A new ${class:name=GtDocument}$ instance is given a ${class:name=GtStorageStrategy}$ instance so that it can read and store its plain text representation. An ${class:name=APWikiLinkAnnotation}$ accesses the wiki class via the ${class:name=GtDocument}$''s storage strategy.
'
]

{ #category : #baseline }
APDocumentation >> baseline: spec [
	<baseline>
	
	spec for: #common do: [

		spec
			baseline: 'GToolkit' 
			with: [ spec repository: 'github://feenkcom/gtoolkit/src' ].

		spec
			package: 'ActivePapers'
			with: [ spec requires: #('GToolkit')];
			package: 'BaselineOfActivePapers'.

]

]
