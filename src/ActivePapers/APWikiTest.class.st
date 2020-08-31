"
Tests for ${class:name=TAPWiki}$

"
Class {
	#name : #APWikiTest,
	#superclass : #TestCase,
	#instVars : [
		'wiki'
	],
	#category : #'ActivePapers-Tests'
}

{ #category : #running }
APWikiTest >> setUp [
	EpMonitor current disable.
	wiki := Object subclass: #APWikiTestExample
						uses: TWkClassWiki
						instanceVariableNames: ''
						classVariableNames: ''
						package: TWkClassWiki package name.
]

{ #category : #running }
APWikiTest >> tearDown [
	wiki removeFromSystem.
	EpMonitor current enable.
]

{ #category : #testing }
APWikiTest >> testMethodSelector [
	self assert: (wiki methodSelectorForWikiPageNamed: #Foo) equals: #wikiPageFoo.
	"Page names are normalized by capitalizaion, so #foo and #Foo are the same."
	self assert: (wiki methodSelectorForWikiPageNamed: #foo) equals: #wikiPageFoo.

]

{ #category : #testing }
APWikiTest >> testPageCreation [
	"Creation of an empty page"
	self assert: (wiki createOrRetrieveWikiPageNamed: #Bar) text
		  equals: wiki initialWikiPageContents.
	"Creation of a page with given content"
	wiki store: '!Page Foo' inWikiPageNamed: #Foo.
	self assert: (wiki wikiPageNamed: #Foo) text equals: '!Page Foo'.

]

{ #category : #testing }
APWikiTest >> testPageNameNormalization [
	| text |
	text := '!A test page'.
	wiki store: text inWikiPageNamed: #foo.
	self assert: (wiki wikiPageNamed: #Foo) text equals: text.
	wiki store: text inWikiPageNamed: #Bar.
	self assert: (wiki wikiPageNamed: #bar) text equals: text.

]

{ #category : #testing }
APWikiTest >> testPageNames [
	wiki createOrRetrieveWikiPageNamed: #Foo.
	wiki createOrRetrieveWikiPageNamed: #Bar.
	wiki createOrRetrieveWikiPageNamed: #Baz.
	self assert: wiki wikiPageNames
		  equals: #(Main Bar Baz Foo)
]
