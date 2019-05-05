Class {
	#name : #APGraphics,
	#superclass : #Object,
	#instVars : [
		'roassalBuilder'
	],
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #'instance creation' }
APGraphics class >> show: anRTBuilder [
	^ self new
		builder: anRTBuilder;
		yourself
]

{ #category : #accessing }
APGraphics >> builder: anRTBuilder [
	roassalBuilder := anRTBuilder
]

{ #category : #inspecting }
APGraphics >> gtViewsFor: aView inContext: aContext [
	| imageForm graphicsElement |
	imageForm := 
		roassalBuilder build view
							setUpCanvas buildMorph imageForm
							trimBordersOfColor: Color white.
	graphicsElement := imageForm asElement.
    ^ aView explicit
        stencil: [ BlElement new
                layout: BlLinearLayout vertical;
                constraintsDo: [ :c | 
                    c horizontal matchParent.
                    c vertical matchParent ];
                padding: (BlInsets all: 5);
                addChild:
                    (BrButton new
                        look: BrGlamorousButtonWithLabelLook;
                        label: 'Inspect in Morphic';
                        action: [ GTInspector inspect: roassalBuilder ];
                        yourself);
                addChild: graphicsElement;
                yourself ]
]
