"
!Annotation for referencing ActivePapers

This is a copy of ${class:name=GtClassAnnotation}$ with two changes: ${method:name=APActivePaperAnnotation>>#tag}$ is different, and ${method:name=APActivePaperAnnotation>>#styleTextWithMarkup:}$ spawns an inspector pane rather than a ${class:name=GtClassCoder}$.
"
Class {
	#name : #APActivePaperAnnotation,
	#superclass : #GtAnnotation,
	#instVars : [
		'referencedClass'
	],
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #accessing }
APActivePaperAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
APActivePaperAnnotation class >> tag [
	^ #activePaper
]

{ #category : #visitor }
APActivePaperAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2ClassAnnotation: self
]

{ #category : #'private - actions' }
APActivePaperAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self isClassDefined ifFalse: [ ^ self inform: 'Class does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedClass realClass;
		sourceElement: anEvent target)
]

{ #category : #'accessing - parameter values' }
APActivePaperAnnotation >> defaultShowSelector [
	^ self constants defaultClassShowSelector
]

{ #category : #testing }
APActivePaperAnnotation >> doesReferenceExist [
	"Return true if a referenced object is defined"
	^ self isClassDefined
]

{ #category : #'announcement handling' }
APActivePaperAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAnnouncement [ 
	(self referencedClass notNil and: [ 
		(aClassAnnouncement classAffected name = self referencedClass name) or: [ 
			aClassAnnouncement classAffected originalName = self referencedClass name ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
APActivePaperAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [ 
	(self referencedClass notNil and: [ 
			aClassRenamed newName = self referencedClass name or: [ 
				aClassRenamed oldName = self referencedClass name ]])
					ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #testing }
APActivePaperAnnotation >> isClassDefined [
	^ self referencedClass notNil and: [ self referencedClass isDefined ]
]

{ #category : #testing }
APActivePaperAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self isClassDefined
]

{ #category : #accessing }
APActivePaperAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self referencedClass realClass
]

{ #category : #accessing }
APActivePaperAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants nameParameterName
]

{ #category : #accessing }
APActivePaperAnnotation >> referencedClass [
	<return: #RGClassDefinition or: nil>
	^ referencedClass ifNil: [ referencedClass := 
		self utility 
			valueOf: self constants nameParameterName
			in: self parameters 
			value: [ :aValue | GtSystemUtility classDefinitionFromString: aValue ] 
			emptyValue: [ nil ] 
			defaultValue: [ nil ] ]
]

{ #category : #subscriptions }
APActivePaperAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: ClassAdded, ClassRemoved
			send: #handleClassAddedOrRemovedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: ClassRenamed
			send: #handleClassRenamedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: GtDocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber.
]

{ #category : #'api - style' }
APActivePaperAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	(self nodeStyler: aBlRope) 
		if: self isClassDefined
			do: [ :aStyler | aStyler 
				name: self referencedClass;
				spawnObject: self referencedClass realClass;
				linkButton ].
	self styleExpandingPreviewInText: aBlRope.
	self registerToSystemChanges
]

{ #category : #'api - style' }
APActivePaperAnnotation >> styleTextWithoutInteractions: aBlRope [
	| aLinkNode |
	aLinkNode := self utility linkNodeForAnnotation: self.
	(aBlRope from: aLinkNode start to: aLinkNode stop) glamorousCodeFont.
	self utility hideAllButLinkInText: aBlRope forAnnotation: self.
]

{ #category : #'api - style' }
APActivePaperAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self nodeStyler: aBlRope)
		if: self isClassDefined 
			do: [ :aStyler | aStyler autoHideNode ]
			otherwise: [ :aStyler |
				aStyler 
					keepChildDisplayed: (self nodeFinder 
						annotationParameter: self referenceParameterName);
					autoHideNode ].
]
