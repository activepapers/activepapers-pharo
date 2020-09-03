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
			baseline: 'DataFrame' with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ];
			baseline: 'PolyMath' with: [ spec repository: 'github://PolyMathOrg/PolyMath/src' ];
			baseline: 'Roassal2' with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ];
			baseline: 'SingletonTrait' with: [ spec repository: 'github://khinsen/SingletonTrait' ];
			baseline: 'WikiForGToolkit' with: [ spec repository: 'github://khinsen/WikiForGToolkit' ].

		spec
			package: 'ActivePapers' with: [ spec requires: #('ActivePapers-Wiki' 'SingletonTrait' 'WikiForGToolkit')];
			package: 'ActivePapers-Wiki';
			package: 'ActivePapersExamples' with: [ spec requires: #('ActivePapers' 'DataFrame' 'PolyMath' 'Roassal2')] ].

	spec for: #gtoolkit do: [
		spec
			baseline: 'IPFSForGToolkit'
			with: [ spec repository: 'github://khinsen/ipfs-pharo/src' ].
		spec
			package: 'ActivePapers' with: [ spec requires: #('IPFSForGToolkit')] ].

	spec for: #'non-gtoolkit' do: [
		spec
			baseline: 'GToolkit' with: [ spec repository: 'github://feenkcom/gtoolkit:release/src' ];
			baseline: 'IPFS' with: [ spec 
				repository: 'github://khinsen/ipfs-pharo/src';
				loads: #('IPFS' 'IPFS-GToolkit') ].
		spec
			package: 'ActivePapers' with: [ spec requires: #('GToolkit' 'IPFS')] ].

]

{ #category : #accessing }
BaselineOfActivePapers >> customProjectAttributes [
	^ self isGTImage
			ifTrue: [ #(gtoolkit) ]
			ifFalse: [ #(non-gtoolkit) ]
]

{ #category : #testing }
BaselineOfActivePapers >> isGTImage [
	^ Smalltalk globals hasClassNamed: #GtCoder
]

{ #category : #baseline }
BaselineOfActivePapers >> postload: loader package: packageSpec [
	"Make sure APDataPoint is compiled after APDataSlot has been loaded."
	APDataPoint recompile.

]
