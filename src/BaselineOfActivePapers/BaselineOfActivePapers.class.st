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
			baseline: 'ObservableSlot'
			with: [ spec repository: 'github://guillep/ObservableSlots/src' ].

		spec
			baseline: 'SingletonTrait'
			with: [ spec repository: 'github://khinsen/SingletonTrait' ].

		spec
			package: 'ActivePapers'
			with: [ spec requires: #('GToolkit' 'ObservableSlot' 'SingletonTrait')];
			package: 'BaselineOfActivePapers'.

]

]
