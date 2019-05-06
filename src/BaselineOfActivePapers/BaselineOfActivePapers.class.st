"
!ActivePapers Pharo edition

The documentation wiki is at ${class:name=APDocumentation}$.

"
Class {
	#name : #BaselineOfActivePapers,
	#superclass : #BaselineOf,
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
			baseline: 'SingletonTrait'
			with: [ spec repository: 'github://khinsen/SingletonTrait' ].
		spec
			baseline: 'DataFrame'
			with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
		spec
			baseline: 'PolyMath'
			with: [ spec repository: 'github://PolyMathOrg/PolyMath/src' ].
		spec
			baseline: 'Roassal2' 
			with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ].

		spec
			package: 'ActivePapers'
			with: [ spec requires: #('GToolkit' 'SingletonTrait')];
			package: 'ActivePapersExamples'
			with: [ spec requires: #('ActivePapers' 'DataFrame' 'PolyMath' 'Roassal2')];
			package: 'BaselineOfActivePapers'.

]

]
