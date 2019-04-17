Class {
	#name : #APCoderSnippet,
	#superclass : #GtCoderSnippet,
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #initialization }
APCoderSnippet >> initialize [
	coder := GtPharoSnippetCoder new.
	super initialize.
	editor := coder sourceEditor.
	shouldSpawn := false.
	coder announcer weak when: GtCoderEvaluationAnnouncement send: #codeEvaluated: to: self.
	self variableBindings: GtSnippetBindings new.
	self subscribeToEditorChanges.
	coder addOns
		addShortcut:
			(BlShortcut new
				combination:
					(BlKeyCombination builder
						primary;
						delete;
						build);
				action: [ :aShortcut | self requestSnippetMerge ]);
		addShortcut:
			(BlShortcut new
				combination:
					(BlKeyCombination builder
						primary;
						return;
						build);
				action: [ :aShortcut | self requestSnippetSplit ])
]
