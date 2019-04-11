Class {
	#name : #BaselineOfActivePapers,
	#superclass : #BaselineOf,
	#traits : 'TAPWiki',
	#classTraits : 'TAPWiki classTrait',
	#category : #BaselineOfActivePapers
}

{ #category : #baseline }
BaselineOfActivePapers >> baseline: spec [
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
