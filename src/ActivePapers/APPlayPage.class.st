Class {
	#name : #APPlayPage,
	#superclass : #GtPlayPage,
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #inspecting }
APPlayPage >> gtViewsFor: aView inContext: aContext [
	^ self gtLiveFor: aView
]

{ #category : #'instance creation' }
APPlayPage >> newDefaultSnippet [
	^ GtCoderSnippet new.
]
