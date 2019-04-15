"
!A ValueHolder for datasets in ActivePapers

Instances of this class are used to store the datasets in ${class:name=APActivePaper}$ documents, via ${class:name=APDataSlot}$ instances managed by ${class:name=TAPData}$. In addition to the actual value of the dataset, its name, time stamp of last modification, and validity flag are stored. The validity flag is initially ==false==, and set to ==true== when a value is set. It can be set back to ==false== using ${method:name=APValueHolder>>#invalidate}$.

Also see ${class:APValueHolderExamples|show=#gtDocumentFor:}$.
"
Class {
	#name : #APValueHolder,
	#superclass : #NewValueHolder,
	#instVars : [
		'name',
		'valid',
		'timeStamp'
	],
	#category : #'ActivePapers-DataSlots'
}

{ #category : #inspecting }
APValueHolder >> gtViewsFor: aView inContext: aContext [
	| view |
	view := value gtViewsFor: aView inContext: aContext.
	view label: (String streamContents: [ :stream | self printOn: stream ]).
	^ view
]

{ #category : #initialization }
APValueHolder >> initialize [
	super initialize.
	valid := false
]

{ #category : #accessing }
APValueHolder >> invalidate [
	valid := false
]

{ #category : #testing }
APValueHolder >> isValid [
	^ valid
]

{ #category : #accessing }
APValueHolder >> name [
	^ name
]

{ #category : #initialization }
APValueHolder >> name: aSymbol [
	name := aSymbol
]

{ #category : #printing }
APValueHolder >> printOn: aStream [
	self isValid
		ifTrue:
			 [ 	aStream nextPutAll: 'Dataset '.
				aStream nextPutAll: self name.
				aStream nextPutAll: ': '.
				aStream print: self value.
				aStream nextPutAll: ' (time stamp: '.
				aStream print: self timeStamp.
				aStream nextPutAll: ')'. ]
		ifFalse:
			 [ 	aStream nextPutAll: 'Invalid dataset '.
				aStream nextPutAll: (self name ifNil: '(no name defined)'
														ifNotNil: [ :n | n ]) ]

]

{ #category : #accessing }
APValueHolder >> restoreState: anArray [
	valid := anArray at: 1.
	value := anArray at: 2.
	timeStamp := anArray at: 3.
]

{ #category : #accessing }
APValueHolder >> state [
	^ { valid. value. timeStamp }
]

{ #category : #accessing }
APValueHolder >> timeStamp [
	^ timeStamp
]

{ #category : #accessing }
APValueHolder >> value [

	self valueRead.
	^ value
]

{ #category : #accessing }
APValueHolder >> value: anObject [
	super value: anObject.
	valid := true.
	timeStamp := DateAndTime now
]

{ #category : #accessing }
APValueHolder >> valueRead [
	
	self announcer announce: (APValueRead value: value)
]

{ #category : #announcing }
APValueHolder >> whenReadDo: aBlock [
	"Culled block [ :value :announcement :announcer | ]"

	| block |
	block := [ :announcement :ann | 
	aBlock
		cull: announcement value
		cull: announcement
		cull: ann ].
	self announcer when: APValueRead do: block
]

{ #category : #announcing }
APValueHolder >> whenReadSend: aSelector to: aReceiver [

	self announcer when: APValueRead send: aSelector to: aReceiver
]
