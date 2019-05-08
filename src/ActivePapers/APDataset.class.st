"
!Dataset in an ActivePaper

Instances of this class is used for displaying individual datasets when inspecting an ${class:name=APActivePaper}$.

"
Class {
	#name : #APDataset,
	#superclass : #Object,
	#instVars : [
		'name',
		'value',
		'timeStamp'
	],
	#category : #'ActivePapers-Data Slots'
}

{ #category : #inspecting }
APDataset >> gtViewsFor: aView inContext: aContext [
	| view |
	view := value gtViewsFor: aView inContext: aContext.
	view label: (String streamContents: [ :stream | self printOn: stream ]).
	^ view
]

{ #category : #accessing }
APDataset >> isValid [
	^ timeStamp isNotNil
]

{ #category : #accessing }
APDataset >> name [
	^ name
]

{ #category : #initialization }
APDataset >> name: aString [
	name := aString
]

{ #category : #printing }
APDataset >> printOn: aStream [
	timeStamp
		ifNotNil:
			 [ 	aStream nextPutAll: 'Dataset '.
				aStream nextPutAll: name.
				aStream nextPutAll: ': '.
				aStream print: value.
				aStream nextPutAll: ' (time stamp: '.
				aStream print: timeStamp.
				aStream nextPutAll: ')'. ]
		ifNil:
			 [ 	aStream nextPutAll: 'Invalid dataset '.
				aStream nextPutAll: (name ifNil: '(no name defined)'
												  ifNotNil: [ :n | n ]) ]

]

{ #category : #accessing }
APDataset >> timeStamp [
	^ timeStamp
]

{ #category : #initialization }
APDataset >> timeStamp: aDateAndTime [
	timeStamp := aDateAndTime
]

{ #category : #accessing }
APDataset >> value [
	^ value
]

{ #category : #initialization }
APDataset >> value: anObject [
	value := anObject
]
