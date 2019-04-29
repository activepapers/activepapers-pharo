"
An announcement used by ${class:name=APValueHolder|show=#gtDocumentFor:}$ in ${method:name=APValueHolder>>#valueRead}$.

"
Class {
	#name : #APValueRead,
	#superclass : #Announcement,
	#instVars : [
		'value'
	],
	#category : #'ActivePapers-OldDataSlots'
}

{ #category : #'instance creation' }
APValueRead class >> value: contents [

	^ self new
		value: contents;
		yourself
]

{ #category : #accessing }
APValueRead >> value [

	^ value
]

{ #category : #accessing }
APValueRead >> value: anObject [

	value := anObject
]
