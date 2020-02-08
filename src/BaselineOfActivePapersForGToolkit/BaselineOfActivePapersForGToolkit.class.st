Class {
	#name : #BaselineOfActivePapersForGToolkit,
	#superclass : #BaselineOf,
	#category : #BaselineOfActivePapersForGToolkit
}

{ #category : #baseline }
BaselineOfActivePapersForGToolkit >> baseline: spec [
	<baseline>
	
	spec for: #common do: [

		spec
			baseline: 'SingletonTrait'
			with: [ spec repository: 'github://khinsen/SingletonTrait' ].
		spec
			baseline: 'IPFSForGToolkit'
			with: [ spec repository: 'github://khinsen/ipfs-pharo/src' ].
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
			with: [ spec requires: #('SingletonTrait' 'IPFSForGToolkit')];
			package: 'ActivePapersExamples'
			with: [ spec requires: #('ActivePapers' 'DataFrame' 'PolyMath' 'Roassal2')];
			package: 'BaselineOfActivePapersForGToolkit'.

]
]

{ #category : #baseline }
BaselineOfActivePapersForGToolkit >> postload: loader package: packageSpec [
	"Make sure APDataPoint is compiled after APDataSlot has been loaded."
	APDataPoint recompile.

]
