!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'support' stamp: 'IB 4/24/2023 14:54:00'!
assertSentencesPrefixedBy: aPrefix match: anExpectedCollectionOfSentences

	|sentences |
	sentences := sentenceFinder sentencesPrefixedBy: aPrefix.
	
    	self assert: sentences size equals: anExpectedCollectionOfSentences size.
	
	self assert: (sentences = anExpectedCollectionOfSentences)! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:26:08'!
testFailsWhenAskedToSearchForAPrefixWithABlankSpace

	self should: [sentenceFinder sentencesPrefixedBy: 'Ho la'] 
		raise: Error 
		withExceptionDo: [:signal | self assert: signal messageText equals: SentenceFinderByPrefix prefixWithBlankSpaceErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:26:16'!
testFailsWhenAskedToSearchForAnEmptyPrefix

	self should: [sentenceFinder sentencesPrefixedBy: ''] 
		raise: Error 
		withExceptionDo: [:signal | self assert: signal messageText equals: SentenceFinderByPrefix emptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:50:30'!
testReturnTwoSentencesWhenTheTwoStoredMatches

    	sentenceFinder storeSentence: self anotherSentence.
    	sentenceFinder storeSentence: self sentence.

	self assertSentencesPrefixedBy: self prefix 
		match: (OrderedCollection with: self anotherSentence with: self sentence)! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:54:29'!
testReturnsEmptyWhenNoSentencesStored

	self assertSentencesPrefixedBy: self prefix match: OrderedCollection new! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:56:00'!
testReturnsEmptyWhenNoneOfTheTwoStoredSentencesMatches

    	sentenceFinder storeSentence: self sentence.
   	sentenceFinder storeSentence: self anotherSentence.

   	self assertSentencesPrefixedBy: self anotherPrefix match: OrderedCollection new! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:56:35'!
testReturnsEmptyWhenTheOnlyStoredSentenceDoesNotMatch

	sentenceFinder storeSentence: self unmatchingSentence.
	
	self assertSentencesPrefixedBy: self prefix match: OrderedCollection new! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:57:04'!
testReturnsSentenceWhenTheOnlyOneStoredMatches

	sentenceFinder storeSentence: self sentence.
	
	self assertSentencesPrefixedBy: self prefix match: (OrderedCollection with: self sentence)! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:57:36'!
testReturnsTheOnlyOneThatMatchesWhenOneSentenceIsInLowerCase

    sentenceFinder storeSentence: self sentence. 
    sentenceFinder storeSentence: self sentenceInLowerCase .

    self assertSentencesPrefixedBy: self prefix match: 	(OrderedCollection with: self sentence)! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:58:14'!
testReturnsTheOnlyOneThatMatchesWhenTwoSentencesStored

	sentenceFinder storeSentence: self sentence.
	sentenceFinder storeSentence: self unmatchingSentence.
    
	self assertSentencesPrefixedBy: self anotherPrefix match: 	(OrderedCollection with: self unmatchingSentence)! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'IB 4/24/2023 14:58:45'!
testReturnsTheOnlyOneThatMatchesWhenTwoSentencesStoredInInverseOrder

    sentenceFinder storeSentence: self sentence. 
    sentenceFinder storeSentence: self unmatchingSentence.

    self assertSentencesPrefixedBy: self prefix match: 	(OrderedCollection with: self sentence)! !


!SentenceFinderByPrefixTest methodsFor: 'support - accessing' stamp: 'IB 4/23/2023 21:17:20'!
anotherPrefix

	^ 'My'! !

!SentenceFinderByPrefixTest methodsFor: 'support - accessing' stamp: 'IB 4/23/2023 21:17:38'!
anotherSentence

	^ 'Regina is the queen bee'! !

!SentenceFinderByPrefixTest methodsFor: 'support - accessing' stamp: 'IB 4/23/2023 21:17:05'!
prefix

	^ 'Regina'! !

!SentenceFinderByPrefixTest methodsFor: 'support - accessing' stamp: 'SG 4/24/2023 13:46:03'!
prefixWithBlankSpaceAtTheEnd

	^ 'Regina '! !

!SentenceFinderByPrefixTest methodsFor: 'support - accessing' stamp: 'IB 4/23/2023 21:16:52'!
sentence

	^ 'Regina is a fugly cow'! !

!SentenceFinderByPrefixTest methodsFor: 'support - accessing' stamp: 'SG 4/24/2023 13:24:41'!
sentenceInLowerCase

	^ 'regina is a fugly cow'! !

!SentenceFinderByPrefixTest methodsFor: 'support - accessing' stamp: 'IB 4/23/2023 21:16:22'!
unmatchingSentence

	^ 'My name is Regina George'! !


!SentenceFinderByPrefixTest methodsFor: 'running' stamp: 'IB 4/23/2023 18:58:14'!
setUp

	sentenceFinder := SentenceFinderByPrefix new.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'IB 4/24/2023 00:34:22'!
initialize

	elements := OrderedCollection with: (OOStackBase for: self)! !


!OOStack methodsFor: 'managing' stamp: 'IB 4/24/2023 00:38:30'!
pop
	
	elements last assertCanBeRemoved.
	^elements removeLast underlyingElement ! !

!OOStack methodsFor: 'managing' stamp: 'IB 4/24/2023 00:38:52'!
push: aElementToPush

	^elements add: (OOStackElement for: aElementToPush)! !


!OOStack methodsFor: 'querying' stamp: 'IB 4/24/2023 00:37:43'!
size

	^elements size - 1! !

!OOStack methodsFor: 'querying' stamp: 'IB 4/24/2023 00:39:08'!
top
	
	elements last assertCanBeRemoved.
	^elements last underlyingElement! !


!OOStack methodsFor: 'error' stamp: 'IB 4/24/2023 00:33:28'!
raiseErrorBecauseCantRemoveStackBase

	self error: self class stackEmptyErrorDescription ! !


!OOStack methodsFor: 'testing' stamp: 'IB 4/24/2023 14:34:47'!
isEmpty
	
	^self size isNothing! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
Object subclass: #OOStackBase
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'asserting' stamp: 'IB 4/24/2023 00:33:02'!
assertCanBeRemoved

	stack raiseErrorBecauseCantRemoveStackBase! !


!OOStackBase methodsFor: 'initialization' stamp: 'IB 4/24/2023 00:31:53'!
initializeFor: anOOStack

	stack := anOOStack! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackBase class' category: 'Stack-Exercise'!
OOStackBase class
	instanceVariableNames: ''!

!OOStackBase class methodsFor: 'instance creation' stamp: 'IB 4/24/2023 00:32:02'!
for: anOOStack

	^self new initializeFor: anOOStack! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'element'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'asserting' stamp: 'IB 4/24/2023 00:26:29'!
assertCanBeRemoved! !


!OOStackElement methodsFor: 'accessing' stamp: 'IB 4/24/2023 00:36:05'!
underlyingElement

	^element value! !


!OOStackElement methodsFor: 'initialization' stamp: 'IB 4/24/2023 00:25:36'!
initializeFor: anUnderlyingElement

	element := anUnderlyingElement ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: 'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'instance creation' stamp: 'IB 4/24/2023 00:23:35'!
for: anUnderlyingElement

	^self new initializeFor: anUnderlyingElement! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentences sentencesToBeRestored'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'querying' stamp: 'IB 4/24/2023 14:14:23'!
sentencesPrefixedBy: aPrefix

	|sentencesThatMatchesThePrefix |
	
	self assertValidPrefix: aPrefix.
	
	sentencesThatMatchesThePrefix := OrderedCollection new.
	
	self withEachStoredSentenceDo: [:sentence |
		self if: sentence matches: aPrefix storeItIn: sentencesThatMatchesThePrefix.
	].

	^sentencesThatMatchesThePrefix reverse! !


!SentenceFinderByPrefix methodsFor: 'utility' stamp: 'IB 4/24/2023 14:00:51'!
if: aSentence matches: aPrefix storeItIn: aCollectionOfSentencesThatMatchesThePrefix

	^(aSentence beginsWith: aPrefix) 
			ifTrue: [aCollectionOfSentencesThatMatchesThePrefix add: aSentence].! !

!SentenceFinderByPrefix methodsFor: 'utility' stamp: 'IB 4/24/2023 14:41:50'!
nextSentence

	^ sentences top! !

!SentenceFinderByPrefix methodsFor: 'utility' stamp: 'IB 4/23/2023 23:38:15'!
restoreSentences

	^ sentencesToBeRestored size timesRepeat: [sentences push: sentencesToBeRestored pop]! !

!SentenceFinderByPrefix methodsFor: 'utility' stamp: 'IB 4/24/2023 14:41:03'!
storeNextSentenceToBeRestoredLater

	^ sentencesToBeRestored push: sentences pop! !

!SentenceFinderByPrefix methodsFor: 'utility' stamp: 'IB 4/24/2023 14:41:50'!
withEachStoredSentenceDo: aBlockToBeExecutedForEachSentence

	sentences size timesRepeat: [
		aBlockToBeExecutedForEachSentence value: self nextSentence.
		self storeNextSentenceToBeRestoredLater
	].
	
	self restoreSentences! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'IB 4/23/2023 23:36:55'!
initialize

	sentences := OOStack new.
	sentencesToBeRestored := OOStack new! !


!SentenceFinderByPrefix methodsFor: 'asserting' stamp: 'IB 4/24/2023 14:27:20'!
assertNotBlankSpacesIn: aPrefix

	^ (self hasBlankSpace: aPrefix) ifTrue: [self error: self class prefixWithBlankSpaceErrorDescription]! !

!SentenceFinderByPrefix methodsFor: 'asserting' stamp: 'IB 4/24/2023 14:27:00'!
assertNotEmpty: aPrefix

	^ aPrefix isEmpty ifTrue: [self error: self class emptyPrefixErrorDescription]! !

!SentenceFinderByPrefix methodsFor: 'asserting' stamp: 'IB 4/24/2023 14:27:24'!
assertValidPrefix: aPrefix
	
	self assertNotEmpty: aPrefix.
	self assertNotBlankSpacesIn: aPrefix! !

!SentenceFinderByPrefix methodsFor: 'asserting' stamp: 'IB 4/24/2023 14:22:09'!
hasBlankSpace: aPrefix

	^ (aPrefix findString: ' ') ~= 0! !


!SentenceFinderByPrefix methodsFor: 'managing' stamp: 'IB 4/23/2023 20:52:11'!
storeSentence: aSentenceToBeStored

	^sentences push: aSentenceToBeStored ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IB 4/24/2023 14:25:00'!
emptyPrefixErrorDescription

	^'The prefix cannot be empty!!!!!!!!!!!!!!!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IB 4/24/2023 14:25:50'!
prefixWithBlankSpaceErrorDescription

	^'The prefix cannot have a blank space!!!!!!!!!!!!!!!!!!!!'! !
