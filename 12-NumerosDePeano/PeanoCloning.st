!classDefinition: #I category: 'PeanoCloning'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'PeanoCloning'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'private' stamp: 'SG 4/2/2023 17:26:15'!
canNotDivideByBiggerNumberErrorDescription
	^'canNotDivideByBiggerNumberErrorDescription'! !

!I class methodsFor: 'private' stamp: 'SG 4/2/2023 17:24:13'!
negativeNumbersNotSupportedErrorDescription
	^'negativeNumbersNotSupportedErrorDescription'! !

!I class methodsFor: 'private'!
! !

!I class methodsFor: 'private'!
! !


!I class methodsFor: 'arithmetic operations'!
! !

!I class methodsFor: 'arithmetic operations'!
! !

!I class methodsFor: 'arithmetic operations' stamp: 'SG 4/2/2023 17:24:23'!
- aNaturalNumber
	(aNaturalNumber == I) ifFalse: (self error: self negativeNumbersNotSupportedErrorDescription). 
	(aNaturalNumber == I) ifTrue: [^I].! !

!I class methodsFor: 'arithmetic operations' stamp: 'SG 4/2/2023 17:27:18'!
/ arg1
	arg1 == self ifTrue: [ ^ self ].
	self error: self canNotDivideByBiggerNumberErrorDescription.! !


!classDefinition: #II category: 'PeanoCloning'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'PeanoCloning'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'arithmetic operations'!
! !

!II class methodsFor: 'arithmetic operations'!
! !

!II class methodsFor: 'arithmetic operations'!
! !

!II class methodsFor: 'arithmetic operations' stamp: 'SG 4/2/2023 17:29:15'!
/ arg1
	arg1 == self ifTrue: [ ^ I ].
	arg1 == I ifTrue: [ ^ self ].
	self error: self canNotDivideByBiggerNumberErrorDescription.! !


!II class methodsFor: 'private auxiliary operations' stamp: 'SG 4/2/2023 17:28:58'!
canNotDivideByBiggerNumberErrorDescription
 	^'canNotDivideByBiggerNumberErrorDescription'! !

!II class methodsFor: 'private auxiliary operations'!
! !

!II class methodsFor: 'private auxiliary operations'!
! !

!II class methodsFor: 'private auxiliary operations'!
! !

!II class methodsFor: 'private auxiliary operations'!
! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'SG 4/2/2023 20:29:42'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'PeanoCloning'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'PeanoCloning'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'arithmetic operations'!
! !

!III class methodsFor: 'arithmetic operations'!
! !

!III class methodsFor: 'arithmetic operations'!
! !

!III class methodsFor: 'arithmetic operations' stamp: 'SG 4/2/2023 17:29:57'!
/ arg1
	arg1 == self ifTrue: [ ^ I ].
	arg1 == I ifTrue: [ ^ self ].
	self error: self canNotDivideByBiggerNumberErrorDescription.! !


!III class methodsFor: 'private auxiliary operations' stamp: 'SG 4/2/2023 17:29:40'!
canNotDivideByBiggerNumberErrorDescription
 	^'canNotDivideByBiggerNumberErrorDescription'! !

!III class methodsFor: 'private auxiliary operations'!
! !

!III class methodsFor: 'private auxiliary operations'!
! !

!III class methodsFor: 'private auxiliary operations'!
! !

!III class methodsFor: 'private auxiliary operations'!
! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'SG 4/2/2023 20:29:42'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'PeanoCloning'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'PeanoCloning'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'arithmetic operations'!
! !

!IIII class methodsFor: 'arithmetic operations'!
! !

!IIII class methodsFor: 'arithmetic operations'!
! !

!IIII class methodsFor: 'arithmetic operations'!
! !


!IIII class methodsFor: 'private auxiliary operations'!
! !

!IIII class methodsFor: 'private auxiliary operations'!
! !

!IIII class methodsFor: 'private auxiliary operations'!
! !

!IIII class methodsFor: 'private auxiliary operations'!
! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'SG 4/2/2023 20:29:42'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!