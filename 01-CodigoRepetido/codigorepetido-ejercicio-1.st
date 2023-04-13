!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'IB 4/12/2023 19:47:19'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self setUpEmptyCustomerBookScenario.
		
	self shouldNotTakeMoreThan: (50 * millisecond) toRun: [self addCustomerNamed: self customerName to: self customerBook] .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IB 4/12/2023 19:53:09'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	self setUpEmptyCustomerBookScenario.
	
	self addCustomerNamed: self customerName to: self customerBook.
	
	self shouldNotTakeMoreThan: (100 * millisecond)  toRun: [self removeCustomerNamed: self customerName from: self customerBook] .
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IB 4/12/2023 19:50:49'!
test03CanNotAddACustomerWithEmptyName 

	self setUpEmptyCustomerBookScenario.
	
	self assert: [ self addCustomerNamed: '' to: self customerBook]
		raises: Error 
		andWithExceptionDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: self customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IB 4/12/2023 19:50:49'!
test04CanNotRemoveAnInvalidCustomer
	
	self setUpEmptyCustomerBookScenario.
	self addCustomerNamed: self anotherCustomerName to: self customerBook.
	
	self assert: [ self removeCustomerNamed: self customerName from: self customerBook]
		raises: NotFound 
		andWithExceptionDo: [ :anError | 
			self assert: self customerBook numberOfCustomers = 1.
			self assert: self customerBook hasCustomerNamed: self anotherCustomerName]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IB 4/12/2023 19:53:03'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	self setUpEmptyCustomerBookScenario.
	
	self addCustomerNamed: self customerName to: self customerBook.
	self suspendCustomerNamed: self customerName from: self customerBook.
	
	self assert: self customerBook has: 1 ofWhichActive: 0 andSuspended: 1.
	self assert: self customerBook hasCustomerNamed: self customerName.
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IB 4/12/2023 19:54:50'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	self setUpEmptyCustomerBookScenario.
	
	self addCustomerNamed: self customerName to: self customerBook.
	self suspendCustomerNamed: self customerName from: self customerBook.
	self removeCustomerNamed: self customerName from: self customerBook.
	
	self assert: self customerBook has: 0 ofWhichActive: 0 andSuspended: 0.
	self deny: (self customerBook hasCustomerNamed: self customerName).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IB 4/12/2023 19:54:56'!
test07CanNotSuspendAnInvalidCustomer
	
	self setUpEmptyCustomerBookScenario.
	
	self addCustomerNamed: self customerName to: self customerBook.
	
	[ self suspendCustomerNamed: self anotherCustomerName from: self customerBook.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: self customerBook numberOfCustomers = 1.
			self assert: self customerBook hasCustomerNamed: self customerName]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IB 4/12/2023 19:55:01'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	self setUpEmptyCustomerBookScenario.
	
	self addCustomerNamed: self anotherCustomerName to: self customerBook.
	self suspendCustomerNamed: self anotherCustomerName from: self customerBook.
	
	[ self suspendCustomerNamed: self anotherCustomerName from: self customerBook.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: self customerBook numberOfCustomers = 1.
			self assert: self customerBook hasCustomerNamed: self anotherCustomerName ]
! !


!CustomerBookTest methodsFor: 'running' stamp: 'IB 4/12/2023 19:57:04'!
setUpEmptyCustomerBookScenario
	
	customerBook := CustomerBook new! !


!CustomerBookTest methodsFor: 'accessing' stamp: 'IB 4/10/2023 21:26:37'!
anotherCustomerName

	^ 'John Lennon'! !

!CustomerBookTest methodsFor: 'accessing' stamp: 'IB 4/12/2023 19:57:04'!
customerBook

	^ customerBook! !

!CustomerBookTest methodsFor: 'accessing' stamp: 'IB 4/10/2023 21:25:56'!
customerName

	^ 'Paul McCartney'! !


!CustomerBookTest methodsFor: 'test support - assertions' stamp: 'IB 4/12/2023 19:18:00'!
assert: aCustomerBook has: aNumberOfCustomers ofWhichActive: aNumberOfActiveCustomers andSuspended: aNumberOfSuspendedCustomers

	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfCustomers equals: aCustomerBook numberOfCustomers! !

!CustomerBookTest methodsFor: 'test support - assertions' stamp: 'IB 4/12/2023 19:30:23'!
assert: aCustomerBook hasCustomerNamed: aName

	self assert: (aCustomerBook hasCustomerNamed: aName)! !

!CustomerBookTest methodsFor: 'test support - assertions' stamp: 'IB 4/12/2023 19:50:49'!
assert: aBlock raises: anError andWithExceptionDo: anotherBlock

	[ aBlock value.
	self fail ]
		on: anError 
		do: anotherBlock! !

!CustomerBookTest methodsFor: 'test support - assertions' stamp: 'IB 4/10/2023 21:28:41'!
shouldNotTakeMoreThan: millisecondsToRun toRun: aBlock

	|  millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < millisecondsToRun
	
! !


!CustomerBookTest methodsFor: 'test support' stamp: 'IB 4/10/2023 21:29:20'!
addCustomerNamed: aName to: aCustomerBook

	^ aCustomerBook addCustomerNamed: aName! !

!CustomerBookTest methodsFor: 'test support' stamp: 'IB 4/12/2023 19:56:34'!
removeCustomerNamed: aName from: aCustomerBook

	^ aCustomerBook removeCustomerNamed: aName! !

!CustomerBookTest methodsFor: 'test support' stamp: 'IB 4/12/2023 19:33:26'!
suspendCustomerNamed: aName from: aCustomerBook 
	
	^aCustomerBook suspendCustomerNamed: aName
	
	! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspendedCustomers activeCustomers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'IB 4/10/2023 20:58:27'!
hasActiveCustomerNamed: aName

	^ activeCustomers includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'IB 4/10/2023 20:40:21'!
hasCustomerNamed: aName

	^ (self hasActiveCustomerNamed: aName) or: [ self hasSuspendedCustomerNamed: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'IB 4/10/2023 20:58:36'!
hasSuspendedCustomerNamed: aName

	^ suspendedCustomers includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'IB 4/10/2023 20:25:13'!
isEmpty
	
	^self numberOfActiveCustomers isNothing and: [ self numberOfSuspendedCustomers isNothing ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'IB 4/10/2023 20:58:19'!
initialize

	activeCustomers := OrderedCollection new.
	suspendedCustomers := OrderedCollection new.! !


!CustomerBook methodsFor: 'customer querying' stamp: 'IB 4/10/2023 20:57:59'!
numberOfActiveCustomers
	
	^activeCustomers size! !

!CustomerBook methodsFor: 'customer querying' stamp: 'IB 4/10/2023 20:39:52'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer querying' stamp: 'IB 4/10/2023 20:58:07'!
numberOfSuspendedCustomers
	
	^suspendedCustomers size! !


!CustomerBook methodsFor: 'customer management' stamp: 'IB 4/10/2023 20:57:16'!
addCustomerNamed: aName

	self assertCanAddCustomerNamed: aName.
	
	activeCustomers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'IB 4/10/2023 20:57:28'!
removeCustomerNamed: aName 
 
	(self hasActiveCustomerNamed: aName) ifTrue: [^activeCustomers remove: aName].
	(self hasSuspendedCustomerNamed: aName) ifTrue: [^suspendedCustomers remove: aName].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IB 4/10/2023 20:57:38'!
suspendCustomerNamed: aName 
	
	self assertCanSuspendCustomerNamed: aName.
	
	activeCustomers remove: aName.
	suspendedCustomers add: aName
! !


!CustomerBook methodsFor: 'asserting' stamp: 'IB 4/10/2023 20:53:54'!
assertCanAddCustomerNamed: aName

 	aName ifEmpty: [ self signalCustomerNameCannotBeEmpty ].
	(self hasCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ]! !

!CustomerBook methodsFor: 'asserting' stamp: 'IB 4/10/2023 20:43:19'!
assertCanSuspendCustomerNamed: aName

	^ (self hasActiveCustomerNamed: aName) ifFalse: [^CantSuspend signal]! !

!CustomerBook methodsFor: 'asserting' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'asserting' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
