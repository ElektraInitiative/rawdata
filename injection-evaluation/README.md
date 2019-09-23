# Injection Evaluation

The 2 `csv` files in this repository contain the evaluation of an automated injection with and without a specification.
The following columns can be found:

1. ErrorType
    
    Can be one of the following: Typo Error, Domain Error, Structure Error, Semantic Error, Limit Error, Resource Error
1. InjectionType

    | Metadata |	Text
    | ------------- |:-------------:|
    | inject/structure/section/duplicate | Section Duplication Error |
    | inject/structure/section/reallocate |	Section Reallocation Error |
    | inject/structure/section/remove | Section Removal Error |
    | inject/semantic |	Semantic Error |
    | inject/resource |	Resource Error |
    | inject/typo/transposition | Typo Char Transition Error |
    | inject/typo/insertion | Typo Char Insertion Error |
    | inject/typo/deletion | Typo Char Deletion Error |
    | inject/typo/change/char |	Typo Char Changing Error |
    | inject/typo/space |	Typo Space Insertion Error |
    | inject/typo/case/toggle | Typo Case Toggle Error |
    | inject/domain	| Domain Error |
    | inject/limit/max | Max Off-by-one Error |
    | inject/limit/min | Min Off-by-one Error |
1. Key

    The Key which is affected by the injection
1. Old Value

    The previous value or `(null)` if it was empty
1. New Value

    The new value
1. Error Message

    A filtered message which tries to detect errors (e.g. [ERROR] for java logs) for the application
1. SpecMessage

    The `reason` metadata which was emitted by Elektra
1. SpecCaught

    `x` if Elektra caught it, otherwise empty
1. SpecPlugin

    Which specification plugin caught the error
1. Log Message

    The full log information from the application. In some cases it was manually deleted because of checks done manually
1. Reaction App

    One of the following reactions can be possible for the application:

    1. GOOD:
        The exception points to the injected error in some way
    1. NONE:
        There is no exception thrown despite it should be
    1. BAD:
        An exception is thrown but is misleading
    1. DEFAULT:
        No exception is thrown but also not necessary because the application handles the case correctly
1. Reaction Spec

    The same as `Reaction App` but for Elektra
1. Pinpoint Spec

    1. GOOD: 
        Key, Value and Reason(Context is given)
    1. NONE: 
        Only if the reaction itself is NONE or BAD
    1. BAD: 
        The exception does not yield relevant information for the location
    1. DEFAULT: 
        If DEFAULT was the reaction
    1. PARTLY: 
        If either Key or Value was given for the wrong configuration setting

1. Vocab Spec

    1. GOOD: If no advanced vocabulary is used
    1. BAD: If too advanced words are being used or confusing text appears (e.g., `stat file`, `normalize value`, classnames unrelated to the exception in java, etc.)
1. Pinpoint App

    Same as `Pinpoint Spec` just for the application
1. Vocab App

    Same as `Vocab Spec` just for the application
1. Personify App

    If the error message is apologetic and personified (e.g., "Sorry, I could not find the XY)
1. LeakInt App

    If internas of the application are leaked such as method names, POJO structures, etc.
1. Comment

    Sometimes comments are done such as bug indication or additional text to interesting cases